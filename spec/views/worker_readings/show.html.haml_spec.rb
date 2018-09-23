require 'rails_helper'

RSpec.describe "worker_readings/show", type: :view do
  before(:each) do
    @worker_reading = assign(:worker_reading, WorkerReading.create!(
      :rate => "9.99",
      :worker_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
  end
end
