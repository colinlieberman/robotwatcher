require 'rails_helper'

RSpec.describe "workers/edit", type: :view do
  before(:each) do
    @worker = assign(:worker, Worker.create!(
      :name => "MyText"
    ))
  end

  it "renders the edit worker form" do
    render

    assert_select "form[action=?][method=?]", worker_path(@worker), "post" do

      assert_select "textarea#worker_name[name=?]", "worker[name]"
    end
  end
end
