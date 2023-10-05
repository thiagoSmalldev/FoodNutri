require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response when product exists' do
      product = create(:food)
      get :show, params: { id: product.id }
      expect(response).to be_successful
    end

    it 'returns a not_found response when product does not exist' do
      get :show, params: { id: 'nonexistent_id' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    it 'creates a new product' do
      product_params = attributes_for(:food)

      post :create, params: { product: product_params }
      expect(response).to have_http_status(:created)
    end

    it 'returns unprocessable_entity when product is invalid' do
      invalid_product_params = attributes_for(:food, code: nil)
      post :create, params: { product: invalid_product_params }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT #update' do
    it 'updates an existing product' do
      product = create(:food)
      updated_attributes = { status: 'updated' }
      put :update, params: { id: product.id, product: updated_attributes }
      expect(response).to be_successful
      expect(product.reload.status).to eq('updated')
    end

    it 'returns a not_found response when product does not exist' do
      put :update, params: { id: 'nonexistent_id', product: { status: 'updated' } }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    it 'changes the status of an existing product to "trash"' do
      product = create(:food)
      delete :destroy, params: { id: product.id }
      expect(response).to be_successful
      expect(product.reload.status).to eq('trash')
    end

    it 'returns a not_found response when product does not exist' do
      delete :destroy, params: { id: 'nonexistent_id' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
