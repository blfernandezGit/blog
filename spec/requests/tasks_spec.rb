require 'rails_helper'

RSpec.describe "/tasks", type: :request do
  before(:each) do
    User.destroy_all
    sign_in create(:user)
    Category.create!(name: "Category", user_id: User.first.id)
end
  
  # Task. As you add validations to Task, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: "Task 1",
    body: "This is the valid task body",
    task_date: Date.current,
    category_id: Category.first.id}
  }

  let(:invalid_attributes) {
    {name: nil,
    body: nil,
    task_date: nil,
    category_id: Category.first.id}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get category_url(Category.first)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = Task.create! valid_attributes
      get category_task_url(Category.first, task)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
    get new_category_task_url(Category.first)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      task = Task.create! valid_attributes
      get edit_category_task_url(Category.first, task)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post category_tasks_url(Category.first), params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post category_tasks_url(Category.first), params: { task: valid_attributes }
        expect(response).to redirect_to(category_task_url(Category.first, Task.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post category_tasks_url(Category.first), params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post category_tasks_url(Category.first), params: { task: invalid_attributes }
        expect(response.status).to eq(422)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {name: "Task 2",
        body: "This is the valid task edited",
        task_date: Date.current,
        category_id: Category.first.id}
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        patch category_task_url(Category.first, task), params: { task: new_attributes }
        task.reload
        expect(Task.last.name).to eq("Task 2")
        expect(Task.last.body).to eq("This is the valid task edited")
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        patch category_task_url(Category.first, task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(category_task_url(Category.first, task))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        task = Task.create! valid_attributes
        patch category_task_url(Category.first, task), params: { task: invalid_attributes }
        expect(response.status).to eq(422)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete category_task_url(Category.first, task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete category_task_url(Category.first, task)
      expect(response).to redirect_to(category_url(Category.first))
    end
  end

  describe "GET /show_tasks_today" do
    it "shows all Tasks for today" do
        get '/tasks/show_tasks_today'

        expect(response).to be_successful
        expect(response).to render_template(:show_tasks_today)
    end
  end
end
