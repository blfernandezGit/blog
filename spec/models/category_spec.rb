require 'rails_helper'

category_name = 'Jet_test_name_1'
presence_error = " can't be blank"
uniqueness_error = " has already been taken"

RSpec.describe Category, driver: :selenium_chrome, js: true do
  before(:all) do Category.create(name: category_name) end

  let!(:category) {Category.order('id').first}

  context "1. Create a category that can be used to organize user's tasks" do
    it "Creates category" do
      visit '/categories'
      
      click_on 'New Category'
      
      category_name2 = 'Jet_test_name_2'
      fill_in 'Name', with: category_name2
      
      click_on 'Create Category'
      
      expect(Category.count).to eq(2)
      expect(page).to have_content (category_name2)
      category_post = Category.order('id').last
      expect(category_post.name).to eq(category_name2)
    end

    it "Is not valid without a name" do
      visit '/categories/new'
      
      click_on 'Create Category'
      
      expect(Category.count).to eq(1)
      expect(page).to have_content ("Name#{presence_error}")
      category_post = Category.order('id').last
      expect(category_post.name).to eq(category_name)
    end

    it "Is not valid when name is duplicated" do
      visit '/categories/new'
      
      fill_in 'Name', with: category_name
      
      click_on 'Create Category'
      
      expect(Category.count).to eq(1)
      expect(page).to have_content ("Name#{uniqueness_error}")
      category_post = Category.order('id').last
      expect(category_post.name).to eq(category_name)
    end
  end

  context "2. Edit a category to update the category's details" do
    it "Updates category" do
      visit '/categories'
      
      click_on 'Edit'
      
      category_name_edited = 'Jet_test_name_edited'
      fill_in 'Name', with: category_name_edited
      
      click_on 'Update Category'
      
      expect(page).to_not have_content (category_name)
      expect(page).to have_content (category_name_edited)
      category_post = Category.order('id').last
      expect(category_post.name).to_not eq(category_name)
      expect(category_post.name).to eq(category_name_edited)
      expect(Category.count).to eq(1)
    end

    it "Is not valid without a name" do
      visit "/categories/#{category.id}/edit"
      
      fill_in 'Name', with: ''
      
      click_on 'Update Category'
      
      expect(page).to have_content ("Name#{presence_error}")
      category_post = Category.order('id').last
      expect(category_post.name).to be_present
      expect(category_post.name).to eq(category_name)
      expect(category_post.name).to_not be_nil
      expect(Category.count).to eq(1)
    end

    it "Is not valid when name is duplicated" do
      category_name2 = 'Jet_test_name_2'
      category_new = Category.create(name: category_name2)
      visit "/categories/#{category_new.id}/edit"
      sleep(10)
      fill_in 'Name', with: category_name
      
      click_on 'Update Category'
      
      expect(page).to have_content ("Name#{uniqueness_error}")
      category_post = Category.order('id').last
      expect(category_post.name).to eq(category_name2)
      expect(Category.count).to eq(2)
    end
  end

  context "3. View a category to show the category's details" do
    it "Shows category" do
      # visit "/categories/#{category.id}"
      visit '/categories'
      
      click_on 'Show'
      
      expect(page).to have_content ("Name: #{category_name}")
    end
  end
end
