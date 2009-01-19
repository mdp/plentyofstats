require 'plenty_of_stats'


pos = PlentyOfStats.new('drinkers', YAML::load(File.open( 'options.yaml' ))['drinkers'])
pos.scrape