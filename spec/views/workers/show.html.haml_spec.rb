require 'rails_helper'

RSpec.describe "workers/show", type: :view do
  before(:each) do
    @worker = assign(:worker, Worker.create!(
      :name => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
