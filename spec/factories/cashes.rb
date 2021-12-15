FactoryBot.define do
  factory :cash do
    balance { "9.99" }
    last_cash_in_amt { "9.99" }
    user { nil }
  end
end
