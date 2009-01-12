require 'rubygems'
require 'dm-core'
require 'dm-types'
require 'dm-timestamps'

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/db/test.db")

class Runs
  include DataMapper::Resource
  
  property :id,     Serial
  property :description, String
  property :created_at, DateTime
  
  has n, :stats
  
end

class Stats
  include DataMapper::Resource
  
  property :id,     Serial
  property :run_id,     Integer
  property :zipcode,  Integer
  property :age, Integer
  property :gender, String  
  property :results, String  
  property :created_on, DateTime  
  
  belongs_to :run
  
end