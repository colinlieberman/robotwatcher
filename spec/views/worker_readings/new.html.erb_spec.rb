require 'rails_helper'

RSpec.describe "worker_readings/new", type: :view do
  before(:each) do
    assign(:worker_reading, WorkerReading.new())
  end

  it "renders new worker_reading form" do
    render

    assert_select "form[action=?][method=?]", worker_readings_path, "post" do
    end
  end
end
