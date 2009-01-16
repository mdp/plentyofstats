require 'rubygems'
require 'spec'
require 'db'

describe Scrape do

  it "should create a scrape" do
    @scrape = Scrape.new(:description => "test scrape")
    @scrape.save.should be_true
  end
  
end

describe Stat do
  
  before :each do
    @scrape = Scrape.create(:description => "test scrape")
  end
  
  it "should fail to create a stat without required data" do
    @stat = @scrape.stats.build(:age => 32)
    @stat.save.should be_false
  end
  
  it "shouldn't fail to create a stat with required data" do
    @stat = @scrape.stats.build(:age => 32, :zipcode => 12345, :result => 15, :gender => 'm' )
    @stat.save.should be_true
  end
  
end