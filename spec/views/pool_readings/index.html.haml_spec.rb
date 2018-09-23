require 'rails_helper'

RSpec.describe "pool_readings/index", type: :view do
  before(:each) do
    assign(:pool_readings, [
      PoolReading.create!(
        :user_rate => "9.99",
        :workers => 2
      ),
      PoolReading.create!(
        :user_rate => "9.99",
        :workers => 2
      )
    ])
  end

  it "renders a list of pool_readings" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
