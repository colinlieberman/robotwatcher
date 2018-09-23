require 'rails_helper'

RSpec.describe "worker_readings/show", type: :view do
  before(:each) do
    @worker_reading = assign(:worker_reading, WorkerReading.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
