class AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @orders = Order.where(fulfilled: false).order(created_at: :desc).take(5)

    daily_orders = Order.where(created_at: Time.now.midnight..Time.now)

    @quick_stats = {
      sales: daily_orders.count,
      revenue: daily_orders.sum(:total)&.round(),
      avg_sale: daily_orders.average(:total)&.round() || 0,
      per_sale: OrderProduct.joins(:order).where(orders: { created_at: Time.now.midnight..Time.now })&.average(:quantity)
    }

    start_date = Time.now.beginning_of_day.utc - 6.days
    end_date = Time.now.end_of_day.utc

    orders_by_day = Order.where(created_at: start_date..end_date)
                        .group("DATE(created_at)")
                        .sum(:total)


    @revenue_by_day = (start_date.to_date..end_date.to_date).map do |day|
      revenue = orders_by_day[day.to_date] || 0
      [ day.strftime("%A"), revenue ]
    end.to_h

    days_of_week = Date::DAYNAMES.rotate(Date.today.wday + 1) # Rotate to start with Monday and place current day last

    @revenue_by_day = days_of_week.map do |day|
      [ day, @revenue_by_day[day] || 0 ]
    end
  end
end
