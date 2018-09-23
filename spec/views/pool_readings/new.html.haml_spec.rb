require 'rails_helper'

RSpec.describe "pool_readings/new", type: :view do
  before(:each) do
    assign(:pool_reading, PoolReading.new(
      :user_rate => "9.99",
      :workers => 1
    ))
  end

  it "renders new pool_reading form" do
    render

    assert_select "form[action=?][method=?]", pool_readings_path, "post" do

      assert_select "input#pool_reading_user_rate[name=?]", "pool_reading[user_rate]"

      assert_select "input#pool_reading_workers[name=?]", "pool_reading[workers]"
    end
  end
end
