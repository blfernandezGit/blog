require 'rails_helper'

RSpec.describe "cashes/edit", type: :view do
  before(:each) do
    @cash = assign(:cash, Cash.create!(
      balance: "9.99",
      last_cash_in_amt: "9.99",
      user: nil
    ))
  end

  it "renders the edit cash form" do
    render

    assert_select "form[action=?][method=?]", cash_path(@cash), "post" do

      assert_select "input[name=?]", "cash[balance]"

      assert_select "input[name=?]", "cash[last_cash_in_amt]"

      assert_select "input[name=?]", "cash[user_id]"
    end
  end
end
