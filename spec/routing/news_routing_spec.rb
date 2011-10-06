require "spec_helper"

describe NewsController do
  describe "routing" do
    it "GET /news routes to #index" do
      get("/news").should route_to("news#index")
    end

    it "GET /projects/:project_id/news routes to #index" do
      get("/projects/some_project/news").should route_to("news#index", :project_id => "some_project")
    end

    it "GET /projects/:project_id/news/new routes to #new" do
      get("/projects/some_project/news/new").should route_to("news#new", :project_id => "some_project")
    end

    it "GET /news/:id routes to #show" do
      get("/news/1").should route_to("news#show", :id => "1")
    end

    it "GET /news/:id/edit routes to #edit" do
      get("/news/1/edit").should route_to("news#edit", :id => "1")
    end

    it "POST /projects/:project_id/news routes to #create" do
      post("/projects/some_project/news").should route_to("news#create", :project_id => "some_project")
    end

    it "PUT /news/:id routes to #update" do
      put("/news/1").should route_to("news#update", :id => "1")
    end

    it "DELETE /news/:id routes to #destroy" do
      delete("/news/1").should route_to("news#destroy", :id => "1")
    end
  end
end
