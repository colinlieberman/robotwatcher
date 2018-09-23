require 'rails_helper'

RSpec.describe "WorkerReadings", type: :request do
  describe "GET /worker_readings" do
    it "works! (now write some real specs)" do
      get worker_readings_path
      expect(response).to have_http_status(200)
    end
  end
end
