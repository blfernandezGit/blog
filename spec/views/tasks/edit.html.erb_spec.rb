# require 'rails_helper'

# RSpec.describe "tasks/edit", type: :view do
#   before(:each) do
#     @task = assign(:task, Task.create!(
#       name: "MyString",
#       body: "MyStringMinimumOf10",
#       category: Category.first
#     ))
#   end

#   it "renders the edit task form" do
#     render

#     assert_select "form[action=?][method=?]", category_task_path(@task.category, @task), "post" do

#       assert_select "input[name=?]", "task[name]"

#       assert_select "input[name=?]", "task[body]"

#       assert_select "input[name=?]", "task[category_id]"
#     end
#   end
# end
