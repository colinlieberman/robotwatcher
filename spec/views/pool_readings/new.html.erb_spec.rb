require 'rails_helper'

RSpec.describe "pool_readings/new", type: :view do
  before(:each) do
    assign(:pool_reading, PoolReading.new())
  end

  it "renders new pool_reading form" do
    render

    assert_select "form[action=?][method=?]", pool_readings_path, "post" do
    end
  end
end
