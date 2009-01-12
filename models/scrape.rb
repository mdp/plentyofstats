class Scrape
  include DataMapper::Resource
  
  property :id,     Serial
  property :description, String
  property :created_at, DateTime
  
  has n, :stats
  
end