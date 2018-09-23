require 'rails_helper'

RSpec.describe "worker_readings/index", type: :view do
  before(:each) do
    assign(:worker_readings, [
      WorkerReading.create!(
        :rate => "9.99",
        :worker_id => 2
      ),
      WorkerReading.create!(
        :rate => "9.99",
        :worker_id => 2
      )
    ])
  end

  it "renders a list of worker_readings" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
