class StripeWebhooksController < ApplicationController
  skip_forgery_protection

  def checkout
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_key)

    event = verify_webhook_signature(payload, sig_header, endpoint_secret)
    return unless event

    handle_checkout_event(event)

    render json: { message: "success" }
  end

  private

  def verify_webhook_signature(payload, sig_header, endpoint_secret)
    begin
      Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      Rails.logger.error "Webhook payload parsing failed: #{e.message}"
      head :bad_request
      nil # Return nil to indicate failure
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error "Webhook signature verification failed: #{e.message}"
      head :bad_request
      nil
    end
  end

  def handle_checkout_event(event)
    case event.type
    when "checkout.session.completed"
      process_completed_session(event.data.object)
    else
      Rails.logger.info "Unhandled event type: #{event.type}"
    end
  end

  def process_completed_session(session)
    shipping_details = session["shipping_details"]
    address = extract_address(shipping_details)

    order = Order.create!(
      customer_email: session["customer_details"]["email"],
      total: session["amount_total"],
      address: address,
      fulfilled: false
    )

    fetch_and_create_order_items(session, order)
  end

  def extract_address(shipping_details)
    if shipping_details
      "#{shipping_details['address']['line1']} #{shipping_details['address']['city']}, #{shipping_details['address']['state']} #{shipping_details['address']['postal_code']}"
    else
      ""
    end
  end

  def fetch_and_create_order_items(session, order)
    full_session = Stripe::Checkout::Session.retrieve({
      id: session.id,
      expand: [ "line_items" ]
    })
    line_items = full_session.line_items

    line_items["data"].each do |item|
      product = Stripe::Product.retrieve(item["price"]["product"])
      OrderProduct.create!(
        order: order,
        product_id: product["metadata"]["product_id"].to_i,
        quantity: item["quantity"],
        size: product["metadata"]["size"]
      )
      Stock.find(product["metadata"]["product_stock_id"]).decrement!(:amount, item["quantity"])
    end
  end
end
