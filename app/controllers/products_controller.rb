class ProductsController < ApplicationController
  skip_before_action :authenticate
  def index
    if params[:keyword]
      @keyword = params[:keyword]
      return if @items = RakutenWebService::Ichiba::Item.search(keyword: @keyword)
    end
  end
end
