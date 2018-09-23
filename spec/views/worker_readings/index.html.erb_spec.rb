require 'rails_helper'

RSpec.describe "worker_readings/index", type: :view do
  before(:each) do
    assign(:worker_readings, [
      WorkerReading.create!(),
      WorkerReading.create!()
    ])
  end

  it "renders a list of worker_readings" do
    render
  end
end
