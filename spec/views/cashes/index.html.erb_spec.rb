require 'rails_helper'

RSpec.describe "cashes/index", type: :view do
  before(:each) do
    assign(:cashes, [
      Cash.create!(
        balance: "9.99",
        last_cash_in_amt: "9.99",
        user: nil
      ),
      Cash.create!(
        balance: "9.99",
        last_cash_in_amt: "9.99",
        user: nil
      )
    ])
  end

  it "renders a list of cashes" do
    render
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
