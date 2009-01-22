require 'rubygems'
require 'dm-core'
require 'dm-types'
require 'dm-timestamps'
require 'dm-validations'

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/db/pos.sqlite")

class Stat
  include DataMapper::Resource
  
  property :id, Serial
  property :scrape, String, :nullable => false
  property :zipcode, Integer, :nullable => false
  property :radius, Integer, :nullable => false
  property :age, Integer, :nullable => false
  property :gender, String, :nullable => false
  property :result, Integer, :nullable => false
  property :url, Text # for debug purposes
  property :created_at, DateTime  
  
end