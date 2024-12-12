# frozen_string_literal: true

class TestimonialReviewComponent < ViewComponent::Base
  def initialize(review:, customer_name:)
    @review = review
    @customer_name = customer_name
  end
end
