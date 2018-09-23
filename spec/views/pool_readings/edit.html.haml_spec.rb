require 'rails_helper'

RSpec.describe "pool_readings/edit", type: :view do
  before(:each) do
    @pool_reading = assign(:pool_reading, PoolReading.create!(
      :user_rate => "9.99",
      :workers => 1
    ))
  end

  it "renders the edit pool_reading form" do
    render

    assert_select "form[action=?][method=?]", pool_reading_path(@pool_reading), "post" do

      assert_select "input#pool_reading_user_rate[name=?]", "pool_reading[user_rate]"

      assert_select "input#pool_reading_workers[name=?]", "pool_reading[workers]"
    end
  end
end
