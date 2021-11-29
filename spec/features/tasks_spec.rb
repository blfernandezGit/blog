require 'rails_helper'

create_success_message = "Task was successfully created"
update_success_message = "Task was successfully updated"
presence_error = " can't be blank"
uniqueness_error = " has already been taken"
minimum_char_error = " should have a minimum of 10 characters"

RSpec.describe Task, type: :feature do
    before(:all) do
        Task.destroy_all
        Category.destroy_all
        Category.create(name:"Category")
    end

    let(:valid_attributes) {
        {name: "Task 1",
        body: "This is the valid task body",
        task_date: Time.current,
        category_id: Category.first.id}
    }

    let(:today_attributes) {
        {name: "Task 2",
        body: "This is the second valid task body",
        task_date: Time.current,
        category_id: Category.last.id}
    }

    let(:next_day_attributes) {
        {name: "Task 3",
        body: "This is the third valid task body",
        task_date: Date.current+1,
        category_id: Category.first.id}
    }

    let(:invalid_attributes_1) {
        {name: nil,
        body: "This is a valid task body"}
    }

    let(:invalid_attributes_2) {
        {name: "Task 1",
        body: nil}
    }

    let(:invalid_attributes_3) {
        {name: "Task 1",
        body: "Invalid"}
    }

    describe "4. Create a task for a specific category so that user can organize tasks quicker" do
        context "with valid parameters" do
            it "creates a new Task" do
                visit '/categories'
                click_on 'Show'
                click_on 'New Task'

                expect(page).to have_current_path new_category_task_path(Category.first)

                fill_in 'Name', with: valid_attributes[:name]
                fill_in 'Body', with: valid_attributes[:body]
                
                click_on 'Create Task'
                
                expect(page).to have_current_path category_task_path(Category.first, Category.first.tasks.first)
                expect(page).to have_content (valid_attributes[:name])
                expect(page).to have_content (valid_attributes[:body])
                expect(page).to have_content (create_success_message)
                expect(Category.first.tasks.count).to eq(1)
            end
        end

        context "with invalid parameters" do
            it 'is not valid without a name' do
                visit "/categories/#{Category.first.id}"

                click_on 'New Task'

                fill_in 'Name', with: invalid_attributes_1[:name]
                fill_in 'Body', with: invalid_attributes_1[:body]
                
                click_on 'Create Task'
                
                expect(page).to have_current_path category_tasks_path(Category.first)
                expect(page).to have_content ("Name#{presence_error}")
                expect(Category.first.tasks.count).to eq(0)
            end
    
            it 'is not valid without a body' do
                visit "/categories/#{Category.first.id}"

                click_on 'New Task'

                fill_in 'Name', with: invalid_attributes_2[:name]
                fill_in 'Body', with: invalid_attributes_2[:body]
                
                click_on 'Create Task'
                
                expect(page).to have_current_path category_tasks_path(Category.first)
                expect(page).to have_content ("Body#{presence_error}")
                expect(Category.first.tasks.count).to eq(0)
            end
    
            it 'is not valid when name is duplicated' do
                visit "/categories/#{Category.first.id}"

                click_on 'New Task'

                fill_in 'Name', with: valid_attributes[:name]
                fill_in 'Body', with: valid_attributes[:body]
                
                click_on 'Create Task'

                click_on 'Back'

                click_on 'New Task'

                fill_in 'Name', with: valid_attributes[:name]
                fill_in 'Body', with: valid_attributes[:body]
                
                click_on 'Create Task'
                
                expect(page).to have_current_path category_tasks_path(Category.first)
                expect(page).to have_content ("Name#{uniqueness_error}")
                expect(Category.first.tasks.count).to eq(1)
            end

            it 'is not valid when body has less than 10 characters' do
                visit "/categories/#{Category.first.id}"

                click_on 'New Task'

                fill_in 'Name', with: invalid_attributes_3[:name]
                fill_in 'Body', with: invalid_attributes_3[:body]
                
                click_on 'Create Task'
                
                expect(page).to have_current_path category_tasks_path(Category.first)
                expect(page).to have_content ("Body#{minimum_char_error}")
                expect(Category.first.tasks.count).to eq(0)
            end
        end
    end

    describe "5. Edit a task to update task's details" do
        context "with valid parameters" do
            let(:new_attributes) {
                {name: "Task 2",
                body: "This is the valid task edited"}
            }

            it "updates the Task" do
                visit '/categories'
                click_on 'Show'
                click_on 'New Task'

                fill_in 'Name', with: valid_attributes[:name]
                fill_in 'Body', with: valid_attributes[:body]
                
                click_on 'Create Task'

                click_on 'Back'

                click_on 'Edit'

                expect(page).to have_current_path edit_category_task_path(Category.first, Category.first.tasks.first)

                fill_in 'Name', with: new_attributes[:name]
                fill_in 'Body', with: new_attributes[:body]

                click_on 'Update Task'

                expect(page).to have_current_path category_task_path(Category.first, Category.first.tasks.first)
                expect(page).to have_content (update_success_message)
                expect(Category.first.tasks.count).to eq(1)
            end
        end

        context "with invalid parameters" do
            let(:valid_attributes_2) {
                {name: "Task 2",
                body: "This is the valid task body"}
            }

            it 'is not valid without a name' do
                visit "/categories/#{Category.first.id}"
                click_on 'New Task'

                fill_in 'Name', with: valid_attributes[:name]
                fill_in 'Body', with: valid_attributes[:body]
                
                click_on 'Create Task'

                click_on 'Back'

                click_on 'Edit'

                fill_in 'Name', with: invalid_attributes_1[:name]
                fill_in 'Body', with: invalid_attributes_1[:body]

                click_on 'Update Task'

                expect(page).to have_current_path category_task_path(Category.first, Category.first.tasks.first)
                expect(page).to have_content ("Name#{presence_error}")
                expect(Category.first.tasks.count).to eq(1)
            end
    
            it 'is not valid without a body' do
                visit "/categories/#{Category.first.id}"
                click_on 'New Task'

                fill_in 'Name', with: valid_attributes[:name]
                fill_in 'Body', with: valid_attributes[:body]
                
                click_on 'Create Task'

                click_on 'Back'

                click_on 'Edit'

                fill_in 'Name', with: invalid_attributes_2[:name]
                fill_in 'Body', with: invalid_attributes_2[:body]

                click_on 'Update Task'

                expect(page).to have_current_path category_task_path(Category.first, Category.first.tasks.first)
                expect(page).to have_content ("Body#{presence_error}")
                expect(Category.first.tasks.count).to eq(1)
            end
    
            it 'is not valid when name is duplicated' do
                visit "/categories/#{Category.first.id}"
                click_on 'New Task'

                fill_in 'Name', with: valid_attributes[:name]
                fill_in 'Body', with: valid_attributes[:body]
                
                click_on 'Create Task'

                click_on 'Back'

                click_on 'New Task'

                fill_in 'Name', with: valid_attributes_2[:name]
                fill_in 'Body', with: valid_attributes_2[:body]
                
                click_on 'Create Task'

                click_on 'Back'

                page.all('a')[5].click

                fill_in 'Name', with: valid_attributes[:name]
                fill_in 'Body', with: valid_attributes[:body]

                click_on 'Update Task'

                expect(page).to have_current_path category_task_path(Category.first, Category.first.tasks.last)
                expect(page).to have_content ("Name#{uniqueness_error}")
                expect(Category.first.tasks.count).to eq(2)
            end

            it 'is not valid when body has less than 3 characters' do
                visit "/categories/#{Category.first.id}"
                click_on 'New Task'

                fill_in 'Name', with: valid_attributes[:name]
                fill_in 'Body', with: valid_attributes[:body]
                
                click_on 'Create Task'

                click_on 'Back'

                click_on 'Edit'

                fill_in 'Name', with: invalid_attributes_3[:name]
                fill_in 'Body', with: invalid_attributes_3[:body]

                click_on 'Update Task'

                expect(page).to have_current_path category_task_path(Category.first, Category.first.tasks.first)
                expect(page).to have_content ("Body#{minimum_char_error}")
                expect(Category.first.tasks.count).to eq(1)
            end
        end
    end

    describe "6. View a task to show task's details" do
        it "shows the Task" do
            visit "/categories/#{Category.first.id}"
            click_on 'New Task'

            fill_in 'Name', with: valid_attributes[:name]
            fill_in 'Body', with: valid_attributes[:body]
            
            click_on 'Create Task'

            click_on 'Back'
            click_on 'Show'

            expect(page).to have_current_path category_task_path(Category.first, Category.first.tasks.first)
            expect(page).to have_content (valid_attributes[:name])
            expect(page).to have_content (valid_attributes[:body])
        end
    end

    describe "7. Delete a task to lessen my unnecessary daily tasks" do
        it "destroys the Task" do
            visit "/categories/#{Category.first.id}"
            click_on 'New Task'

            fill_in 'Name', with: valid_attributes[:name]
            fill_in 'Body', with: valid_attributes[:body]
            
            click_on 'Create Task'

            click_on 'Back'
            click_on 'Destroy'

            expect(page).to have_current_path category_path(Category.first)
            expect(page).to_not have_content (valid_attributes[:name])
            expect(page).to_not have_content (valid_attributes[:body])
        end
    end

    describe "8. View user tasks for today to remind what are the user's priorities for today" do
        it "shows all Tasks for today" do
            Category.create(name:"Category2")
            task_today_1 = Task.create! valid_attributes
            task_today_2 = Task.create! today_attributes
            task_next_day = Task.create! next_day_attributes
            visit "/categories"
            click_on 'Show Tasks for Today'

            expect(page).to have_current_path show_tasks_today_path
            expect(page).to have_content (valid_attributes[:name])
            expect(page).to have_content (today_attributes[:name])
            expect(page).to_not have_content (next_day_attributes[:name])
        end
    end
end

#9: As a User, I want to create my account so that I can have my own credentials
#10: As s User, I want to login my account so that I can access my account and link my own tasks.