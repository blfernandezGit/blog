require 'rails_helper'

RSpec.describe "cashes/show", type: :view do
  before(:each) do
    @cash = assign(:cash, Cash.create!(
      balance: "9.99",
      last_cash_in_amt: "9.99",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
