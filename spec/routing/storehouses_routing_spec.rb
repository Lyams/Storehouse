require "rails_helper"

RSpec.describe StorehousesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/storehouses").to route_to("storehouses#index")
    end

    it "routes to #new" do
      expect(get: "/storehouses/new").to route_to("storehouses#new")
    end

    it "routes to #show" do
      expect(get: "/storehouses/1").to route_to("storehouses#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/storehouses/1/edit").to route_to("storehouses#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/storehouses").to route_to("storehouses#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/storehouses/1").to route_to("storehouses#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/storehouses/1").to route_to("storehouses#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/storehouses/1").to route_to("storehouses#destroy", id: "1")
    end
  end
end
