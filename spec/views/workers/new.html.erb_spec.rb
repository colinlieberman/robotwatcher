require 'rails_helper'

RSpec.describe "workers/new", type: :view do
  before(:each) do
    assign(:worker, Worker.new())
  end

  it "renders new worker form" do
    render

    assert_select "form[action=?][method=?]", workers_path, "post" do
    end
  end
end
