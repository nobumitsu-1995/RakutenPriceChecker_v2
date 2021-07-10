class ProductsController < ApplicationController
  def index
    if params[:keyword]
      @keyword = params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: @keyword)
    end
  end
end
