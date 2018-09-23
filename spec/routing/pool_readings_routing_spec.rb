require "rails_helper"

RSpec.describe PoolReadingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/pool_readings").to route_to("pool_readings#index")
    end

    it "routes to #new" do
      expect(:get => "/pool_readings/new").to route_to("pool_readings#new")
    end

    it "routes to #show" do
      expect(:get => "/pool_readings/1").to route_to("pool_readings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pool_readings/1/edit").to route_to("pool_readings#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/pool_readings").to route_to("pool_readings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pool_readings/1").to route_to("pool_readings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pool_readings/1").to route_to("pool_readings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pool_readings/1").to route_to("pool_readings#destroy", :id => "1")
    end
  end
end
