require 'rails_helper'

RSpec.describe "workers/edit", type: :view do
  before(:each) do
    @worker = assign(:worker, Worker.create!())
  end

  it "renders the edit worker form" do
    render

    assert_select "form[action=?][method=?]", worker_path(@worker), "post" do
    end
  end
end
