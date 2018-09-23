require 'rails_helper'

RSpec.describe "pool_readings/show", type: :view do
  before(:each) do
    @pool_reading = assign(:pool_reading, PoolReading.create!(
      :user_rate => "9.99",
      :workers => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
  end
end
