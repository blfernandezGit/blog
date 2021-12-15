require 'rails_helper'

RSpec.describe "cashes/new", type: :view do
  before(:each) do
    assign(:cash, Cash.new(
      balance: "9.99",
      last_cash_in_amt: "9.99",
      user: nil
    ))
  end

  it "renders new cash form" do
    render

    assert_select "form[action=?][method=?]", cashes_path, "post" do

      assert_select "input[name=?]", "cash[balance]"

      assert_select "input[name=?]", "cash[last_cash_in_amt]"

      assert_select "input[name=?]", "cash[user_id]"
    end
  end
end
