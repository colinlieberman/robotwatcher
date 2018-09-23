require 'rails_helper'

RSpec.describe "PoolReadings", type: :request do
  describe "GET /pool_readings" do
    it "works! (now write some real specs)" do
      get pool_readings_path
      expect(response).to have_http_status(200)
    end
  end
end
