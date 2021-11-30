# require 'rails_helper'

# RSpec.describe "tasks/index", type: :view do
#   before(:each) do
#     assign(:tasks, [
#       Task.create!(
#         name: "Name 1",
#         body: "Body minimum of 10 characters",
#         category: Category.first
#       ),
#       Task.create!(
#         name: "Name 2",
#         body: "Body minimum of 10 characters",
#         category: Category.first
#       )
#     ])
#   end

#   it "renders a list of tasks" do
#     render
#     assert_select "tr>td", text: "Name".to_s, count: 2
#     assert_select "tr>td", text: "Body".to_s, count: 2
#     assert_select "tr>td", text: Category.first.to_s, count: 2
#   end
# end
