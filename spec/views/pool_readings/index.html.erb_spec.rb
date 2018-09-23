require 'rails_helper'

RSpec.describe "pool_readings/index", type: :view do
  before(:each) do
    assign(:pool_readings, [
      PoolReading.create!(),
      PoolReading.create!()
    ])
  end

  it "renders a list of pool_readings" do
    render
  end
end
