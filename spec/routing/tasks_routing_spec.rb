require "rails_helper"

RSpec.describe TasksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/categories/1").to route_to("categories#show", id:"1")
    end

    it "routes to #new" do
      expect(get: "/categories/1/tasks/new").to route_to("tasks#new", category_id:"1")
    end

    it "routes to #show" do
      expect(get: "/categories/1/tasks/1").to route_to("tasks#show", category_id:"1", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/categories/1/tasks/1/edit").to route_to("tasks#edit", category_id:"1",  id: "1")
    end


    it "routes to #create" do
      expect(post: "categories/1/tasks").to route_to("tasks#create",  category_id:"1", )
    end

    it "routes to #update via PUT" do
      expect(put: "/categories/1/tasks/1").to route_to("tasks#update", category_id:"1",  id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/categories/1/tasks/1").to route_to("tasks#update", category_id:"1",  id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/categories/1/tasks/1").to route_to("tasks#destroy", category_id:"1",  id: "1")
    end
  end
end
