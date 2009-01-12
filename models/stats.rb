require 'rubygems'
require 'dm-core'
require 'dm-types'
require 'dm-timestamps'

class Stat
  include DataMapper::Resource
  
  property :id,     Serial
  property :run_id,     Integer
  property :zipcode,  Integer
  property :age, Integer
  property :gender, String  
  property :results, String  
  property :created_on, DateTime  
  
  belongs_to :scrape
  
end