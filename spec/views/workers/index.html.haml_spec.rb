require 'rails_helper'

RSpec.describe "workers/index", type: :view do
  before(:each) do
    assign(:workers, [
      Worker.create!(
        :name => "MyText"
      ),
      Worker.create!(
        :name => "MyText"
      )
    ])
  end

  it "renders a list of workers" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
