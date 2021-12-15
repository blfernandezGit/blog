require 'rails_helper'

RSpec.describe "inventories/edit", type: :view do
  before(:each) do
    @inventory = assign(:inventory, Inventory.create!(
      stock_code: "MyString",
      stock_name: "MyString",
      quantity: 1,
      user: nil
    ))
  end

  it "renders the edit inventory form" do
    render

    assert_select "form[action=?][method=?]", inventory_path(@inventory), "post" do

      assert_select "input[name=?]", "inventory[stock_code]"

      assert_select "input[name=?]", "inventory[stock_name]"

      assert_select "input[name=?]", "inventory[quantity]"

      assert_select "input[name=?]", "inventory[user_id]"
    end
  end
end
