require 'rails_helper'

valid_attributes = {name: "Jet_test_name_4"}
valid_name_2 = "Jet_test_name_5"
valid_attributes_2 = {name: valid_name_2}

RSpec.describe "Categories", type: :request do
  before(:all) do Category.create(name: 'Jet_test_name_3') end

  let!(:category) {Category.order('id').first}

  context "1. Create a category that can be used to organize user's tasks" do
    it "GET /index" do
      get categories_path
      expect(response.status).to eq(200)
      expect(assigns(:categories)).to eq(Category.all)
    end

    it "GET /new" do
      get new_category_path
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end

    it "POST /create" do
      expect do
        post categories_path, params: { category: valid_attributes }
      end.to change(Category, :count).by(1)
      expect(response.status).to eq(200)
      expect(response).to redirect_to(categories_path)
      follow_redirect!
      expect(response).to render_template(:index)
    end
  end

  context "2. Edit a category to update the category's details" do
    it "GET /edit" do
      get "/categories/#{category.id}/edit"
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end

    it "PATCH /update" do
      expect do
        patch "/categories/#{category.id}", params: { category: valid_attributes_2 }
      end.to change{ Category.first.name }.to(valid_name_2)
      expect(response.status).to eq(200)
      expect(response).to redirect_to(categories_path)
      follow_redirect!
      expect(response).to render_template(:index)
    end
  end

  context "3. View a category to show the category's details" do
    it "GET /show" do
      get "/categories/#{category.id}"
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end
  end
end