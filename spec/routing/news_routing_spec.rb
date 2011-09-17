require "spec_helper"

describe NewsController do
  describe "routing" do
    it "routes to #index" do
      get("/news").should route_to("news#index")
    end

    it "routes to #index" do
      get("/projects/some_project/news").should route_to("news#index", :project_id => "some_project")
    end

    it "routes to #new" do
      get("/projects/some_project/news/new").should route_to("news#new", :project_id => "some_project")
    end

    it "routes to #show" do
      get("/news/1").should route_to("news#show", :id => "1")
    end

    it "routes to #edit" do
      get("/news/1/edit").should route_to("news#edit", :id => "1")
    end

    it "routes to #create" do
      post("/projects/some_project/news").should route_to("news#create", :project_id => "some_project")
    end

    it "routes to #update" do
      put("/news/1").should route_to("news#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/news/1").should route_to("news#destroy", :id => "1")
    end
  end
end
