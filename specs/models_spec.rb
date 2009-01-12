require 'rubygems'
require 'spec'
require 'db'

describe Stats do
  
  it "should create a record" do
    p Runs.create(:description => "test").id
  end
  
end