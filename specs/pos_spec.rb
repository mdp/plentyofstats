require 'rubygems'
require 'spec'
require 'plenty_of_stats'

describe PlentyOfStats
  
  it "should work like this" do
    pos = PlentyOfStats.new(YAML::load(File.open( 'options.yaml' ))['baseline'])
    pos.scrape
    # simple, right?
  end
  
  
end