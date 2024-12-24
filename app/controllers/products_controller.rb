class ProductsController < ApplicationController
  before_action :set_active_storage_url_options
  def show
    @product = Product.find(params[:id])
  end

  def set_active_storage_url_options
    ActiveStorage::Current.url_options = {
      protocol: request.protocol,
      host: request.host,
      port: request.port
    }
  end
end
