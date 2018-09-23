require 'rails_helper'

RSpec.describe "pool_readings/show", type: :view do
  before(:each) do
    @pool_reading = assign(:pool_reading, PoolReading.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
