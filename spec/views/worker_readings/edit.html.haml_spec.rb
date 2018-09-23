require 'rails_helper'

RSpec.describe "worker_readings/edit", type: :view do
  before(:each) do
    @worker_reading = assign(:worker_reading, WorkerReading.create!(
      :rate => "9.99",
      :worker_id => 1
    ))
  end

  it "renders the edit worker_reading form" do
    render

    assert_select "form[action=?][method=?]", worker_reading_path(@worker_reading), "post" do

      assert_select "input#worker_reading_rate[name=?]", "worker_reading[rate]"

      assert_select "input#worker_reading_worker_id[name=?]", "worker_reading[worker_id]"
    end
  end
end
