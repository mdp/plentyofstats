require 'plenty_of_stats'


pos = PlentyOfStats.new('baseline test', YAML::load(File.open( 'options.yaml' ))['baseline'])
pos.scrape