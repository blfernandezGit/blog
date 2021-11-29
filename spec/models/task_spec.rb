require 'rails_helper'

RSpec.describe Task, type: :model do
    before(:all) do 
        Category.destroy_all
        Category.create(name:"Category") 
    end

    let(:valid_attributes) {
        {name: "Task 1",
        body: "This is the valid task body",
        task_date: Date.current,
        category_id: Category.first.id}
    }

    let(:invalid_attributes_1) {
        {name: nil,
        body: "This is a valid task body",
        task_date: Date.current,
        category_id: Category.first.id}
    }

    let(:invalid_attributes_2) {
        {name: "Task 1",
        body: nil,
        task_date: Date.current,
        category_id: Category.first.id}
    }

    let(:invalid_attributes_3) {
        {name: "Task 1",
        body: "Invalid",
        task_date: Date.current,
        category_id: Category.first.id}
    }

    describe "4. Create a task for a specific category so that user can organize tasks quicker" do
        context "with valid parameters" do
            it "creates a new Task" do
                task = Task.create! valid_attributes

                expect(task).to be_valid
                expect(task.errors).to_not be_present
                expect(Task.count).to eq(1)
            end
        end

        context "with invalid parameters" do
            it 'is not valid without a name' do
                task = Task.create invalid_attributes_1
    
                expect(task).to_not be_valid
                expect(task.errors).to be_present
                expect(task.errors.to_hash.keys).to include(:name)
            end
    
            it 'is not valid without a body' do
                task = Task.create invalid_attributes_2
    
                expect(task).to_not be_valid
                expect(task.errors).to be_present
                expect(task.errors.to_hash.keys).to include(:body)
            end
    
            it 'is not valid when name is duplicated' do
                task_valid = Task.create! valid_attributes
                task_duplicate = Task.create valid_attributes
    
                expect(task_duplicate).to_not be_valid
                expect(task_duplicate.errors).to be_present
                expect(task_duplicate.errors.to_hash.keys).to include(:name)
            end

            it 'is not valid when body has less than 3 characters' do
                task = Task.create invalid_attributes_3
    
                expect(task).to_not be_valid
                expect(task.errors).to be_present
                expect(task.errors.to_hash.keys).to include(:body)
            end
        end
    end

    describe "5. Edit a task to update task's details" do
        context "with valid parameters" do
            let(:new_attributes) {
                {name: "Task 2",
                body: "This is the valid task edited",
                task_date: Date.current,
                category_id: Category.first.id}
            }

            it "updates the Task" do
                task = Task.create! valid_attributes
                task.update! new_attributes

                expect(task).to be_valid
                expect(task.errors).to_not be_present
                expect(Task.count).to eq(1)
            end
        end

        context "with invalid parameters" do
            let(:valid_attributes_2) {
                {name: "Task 2",
                body: "This is the valid task body",
                task_date: Date.current,
                category_id: Category.first.id}
            }

            it 'is not valid without a name' do
                task = Task.create! valid_attributes
                task.update invalid_attributes_1
    
                expect(task).to_not be_valid
                expect(task.errors).to be_present
                expect(task.errors.to_hash.keys).to include(:name)
            end
    
            it 'is not valid without a body' do
                task = Task.create! valid_attributes
                task.update invalid_attributes_2
    
                expect(task).to_not be_valid
                expect(task.errors).to be_present
                expect(task.errors.to_hash.keys).to include(:body)
            end
    
            it 'is not valid when name is duplicated' do
                task_valid = Task.create! valid_attributes
                task = Task.create! valid_attributes_2
                task.update valid_attributes
    
                expect(task).to_not be_valid
                expect(task.errors).to be_present
                expect(task.errors.to_hash.keys).to include(:name)
            end

            it 'is not valid when body has less than 10 characters' do
                task = Task.create! valid_attributes
                task.update invalid_attributes_3
    
                expect(task).to_not be_valid
                expect(task.errors).to be_present
                expect(task.errors.to_hash.keys).to include(:body)
            end
        end
    end

    describe "7. Delete a task to lessen my unnecessary daily tasks" do
        it "destroys the Task" do
            task = Task.create! valid_attributes
            task.destroy

            expect(task).to be_valid
            expect(task.errors).to_not be_present
            expect(Task.count).to eq(0)
        end
    end
end