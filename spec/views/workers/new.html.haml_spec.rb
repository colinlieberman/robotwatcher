require 'rails_helper'

RSpec.describe "workers/new", type: :view do
  before(:each) do
    assign(:worker, Worker.new(
      :name => "MyText"
    ))
  end

  it "renders new worker form" do
    render

    assert_select "form[action=?][method=?]", workers_path, "post" do

      assert_select "textarea#worker_name[name=?]", "worker[name]"
    end
  end
end
