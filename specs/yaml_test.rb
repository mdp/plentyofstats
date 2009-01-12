require 'yaml'

readme = YAML::load( File.open( 'options.yaml' ) )
p readme['options']