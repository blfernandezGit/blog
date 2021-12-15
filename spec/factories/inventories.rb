FactoryBot.define do
  factory :inventory do
    stock_code { "MyString" }
    stock_name { "MyString" }
    quantity { 1 }
    user { nil }
  end
end
