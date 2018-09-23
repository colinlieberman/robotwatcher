require 'rails_helper'

RSpec.describe "workers/show", type: :view do
  before(:each) do
    @worker = assign(:worker, Worker.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
