require 'rails_helper'

RSpec.describe "workers/index", type: :view do
  before(:each) do
    assign(:workers, [
      Worker.create!(),
      Worker.create!()
    ])
  end

  it "renders a list of workers" do
    render
  end
end
