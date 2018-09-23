require 'rails_helper'

RSpec.describe "worker_readings/new", type: :view do
  before(:each) do
    assign(:worker_reading, WorkerReading.new(
      :rate => "9.99",
      :worker_id => 1
    ))
  end

  it "renders new worker_reading form" do
    render

    assert_select "form[action=?][method=?]", worker_readings_path, "post" do

      assert_select "input#worker_reading_rate[name=?]", "worker_reading[rate]"

      assert_select "input#worker_reading_worker_id[name=?]", "worker_reading[worker_id]"
    end
  end
end
