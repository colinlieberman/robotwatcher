require 'rails_helper'

RSpec.describe "pool_readings/edit", type: :view do
  before(:each) do
    @pool_reading = assign(:pool_reading, PoolReading.create!())
  end

  it "renders the edit pool_reading form" do
    render

    assert_select "form[action=?][method=?]", pool_reading_path(@pool_reading), "post" do
    end
  end
end
