class ProductsController < ApplicationController
  before_filter :authorize, except: [:index, :show, :toggle]

  def index
    @products = Product.all
    @order_item = current_order.order_items.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def toggle
    respond_to do |format|
      format.js { render 'products/toggle_description' }
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to '/'
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :photo)
  end
end
