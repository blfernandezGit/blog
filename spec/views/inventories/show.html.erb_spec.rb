require 'rails_helper'

RSpec.describe "inventories/show", type: :view do
  before(:each) do
    @inventory = assign(:inventory, Inventory.create!(
      stock_code: "Stock Code",
      stock_name: "Stock Name",
      quantity: 2,
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Stock Code/)
    expect(rendered).to match(/Stock Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
