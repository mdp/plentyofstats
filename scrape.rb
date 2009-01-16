require 'plentyofstats'


pos = PlentyOfStats.new(YAML::load(File.open( 'options.yaml' ))['baseline'])
pos.scrape