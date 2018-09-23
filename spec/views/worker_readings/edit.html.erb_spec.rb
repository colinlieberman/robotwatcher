require 'rails_helper'

RSpec.describe "worker_readings/edit", type: :view do
  before(:each) do
    @worker_reading = assign(:worker_reading, WorkerReading.create!())
  end

  it "renders the edit worker_reading form" do
    render

    assert_select "form[action=?][method=?]", worker_reading_path(@worker_reading), "post" do
    end
  end
end
