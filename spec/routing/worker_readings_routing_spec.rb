require "rails_helper"

RSpec.describe WorkerReadingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/worker_readings").to route_to("worker_readings#index")
    end

    it "routes to #new" do
      expect(:get => "/worker_readings/new").to route_to("worker_readings#new")
    end

    it "routes to #show" do
      expect(:get => "/worker_readings/1").to route_to("worker_readings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/worker_readings/1/edit").to route_to("worker_readings#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/worker_readings").to route_to("worker_readings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/worker_readings/1").to route_to("worker_readings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/worker_readings/1").to route_to("worker_readings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/worker_readings/1").to route_to("worker_readings#destroy", :id => "1")
    end
  end
end
