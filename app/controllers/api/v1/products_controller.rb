class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    products = Food.paginate(page: page, per_page: per_page)
    render json: products
  end

  def show
    if @product
      render json: @product
    else
      render json: { error: 'Produto não encontrado' }, status: :not_found
    end
  end

  def create
    @product = Food.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product
      # Atualize os campos do produto conforme necessário
      @product.update_attributes(product_params)
      render json: @product
    else
      render json: { error: 'Produto não encontrado' }, status: :not_found
    end
  end

  def destroy
    if @product
      @product.update(status: 'trash')
      render json: @product
    else
      render json: { error: 'Produto não encontrado' }, status: :not_found
    end
  end

  private

  def set_product
    @product = Food.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :code,
      :status,
      :imported_t,
      :url,
      :creator,
      :created_t,
      :last_modified_t,
      :product_name,
      :quantity,
      :brands,
      :categories,
      :labels,
      :cities,
      :purchase_places,
      :stores,
      :ingredients_text,
      :traces,
      :serving_size,
      :serving_quantity,
      :nutriscore_score,
      :nutriscore_grade,
      :main_category,
      :image_url
    )
  end
end
