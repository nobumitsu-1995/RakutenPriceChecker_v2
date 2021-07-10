class SaveitemsController < ApplicationController
  before_action :set_saveitem, only: [:show, :destroy]
  def index
    @items = Saveitem.where(user_id: current_user.id)
  end

  def show
    @datas = Price.set_datas(current_user, @saveitem)
  end

  def create
    @saveitem = current_user.saveitems.build(saveitem_params)
    if @saveitem.save
      Price.save_price(current_user, @saveitem, params[:price])
      redirect_to saveitems_path, notice: "商品情報を保存しました。"
    else
      redirect_to products_path, alert: "商品の保存に失敗しました。"
    end
  end

  def destroy
    @saveitem.destroy
    redirect_to saveitems_path, notice: "商品情報を削除しました。"
  end

  private

  def set_saveitem
    @saveitem = Saveitem.find(params[:id])
  end

  def saveitem_params
    params.permit(:item_code, :image_url, :url, :name)
  end

end
