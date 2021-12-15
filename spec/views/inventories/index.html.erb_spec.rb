require 'rails_helper'

RSpec.describe "inventories/index", type: :view do
  before(:each) do
    assign(:inventories, [
      Inventory.create!(
        stock_code: "Stock Code",
        stock_name: "Stock Name",
        quantity: 2,
        user: nil
      ),
      Inventory.create!(
        stock_code: "Stock Code",
        stock_name: "Stock Name",
        quantity: 2,
        user: nil
      )
    ])
  end

  it "renders a list of inventories" do
    render
    assert_select "tr>td", text: "Stock Code".to_s, count: 2
    assert_select "tr>td", text: "Stock Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
