class SaveitemsController < ApplicationController
  before_action :set_saveitem, only: [:show, :destroy]
  def index
    @items = Saveitem.where(user_id: current_user.id)
  end

  def show

  end

  def create
    @saveitem = current_user.saveitems.build(
      item_code: params[:item_code],
      image_url: params[:image_url],
      url: params[:url],
      name: params[:name],
    )
    if @saveitem.save
      redirect_to saveitems_path, notice: "商品情報を保存しました。"
    else
      render "products/index"
    end
  end

  def destroy

  end

  private

  def set_saveitem
    @saveitem = Saveitem.find(params[:id])
  end

end
