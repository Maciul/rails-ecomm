class AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @orders = Order.where(fulfilled: false).order(created_at: :desc).take(5)
    @quick_stats = {
      sales: Order.where(created_at: Time.now.midnight..Time.now).count,
      revenue: Order.where(created_at: Time.now.midnight..Time.now).sum(:total)&.round(),
      avg_sale: Order.where(created_at: Time.now.midnight..Time.now).average(:total)&.round(),
      per_sale: OrderProduct.joins(:order).where(orders: { created_at: Time.now.midnight..Time.now })&.average(:quantity)
    }

    start_date = Time.now - 6.days
    end_date = Time.now

    orders_by_day = Order.where(created_at: start_date..end_date)
                        .group("DATE(created_at)")
                        .sum(:total)

    @revenue_by_day = (start_date..end_date).map do |day|
      revenue = orders_by_day[day.to_date] || 0
      [ day.strftime("%A"), revenue ]
    end.to_h

    days_of_week = Date::DAYNAMES.rotate(Date.today.wday + 1) # Rotate to start with Monday and place current day last

    @revenue_by_day = days_of_week.map do |day|
      [ day, @revenue_by_day[day] || 0 ]
    end
  end
end
