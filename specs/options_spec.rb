require 'rubygems'
require 'spec'
require 'yaml'

describe "Should output cities" do
  
  it "should work" do
    YAML::load(File.open( 'cities.yaml' )).size.should == 15
  end
  
end