require 'plenty_of_stats'


pos = PlentyOfStats.new('smokers', YAML::load(File.open( 'options.yaml' ))['smokers'])
pos.scrape