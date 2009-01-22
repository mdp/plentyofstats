require 'plenty_of_stats'


# pos = PlentyOfStats.new('base', YAML::load(File.open( 'options.yaml' ))['base'])
# pos.scrape
# 
# pos = PlentyOfStats.new('drinkers', YAML::load(File.open( 'options.yaml' ))['drinkers'])
# pos.scrape
# 
# pos = PlentyOfStats.new('heavy_drinkers', YAML::load(File.open( 'options.yaml' ))['heavy_drinkers'])
# pos.scrape
# 
# pos = PlentyOfStats.new('smokers', YAML::load(File.open( 'options.yaml' ))['smokers'])
# pos.scrape
# 
# pos = PlentyOfStats.new('heavy_smokers', YAML::load(File.open( 'options.yaml' ))['heavy_smokers'])
# pos.scrape

pos = PlentyOfStats.new('drugs', YAML::load(File.open( 'options.yaml' ))['drugs'])
pos.scrape

pos = PlentyOfStats.new('heavy_drugs', YAML::load(File.open( 'options.yaml' ))['heavy_drugs'])
pos.scrape