class Db < Thor                                                
  require 'db'
  desc "migrate", "Creates a new DB and erases the old"
  def migrate
    puts "Successfully migrated the DB" if DataMapper.auto_migrate!
  end
  
  def autoupgrade
    puts "Successfully migrated the DB" if DataMapper.auto_upgrade!
  end
  
  def fuckit
    FStat.all.each do |s|
      Stat.create(:created_at => s.created_at, :result => s.result, 
                   :age => s.age, :gender => s.gender, :zipcode => s.zipcode, 
                   :url => s.url, :scrape_id => s.scrape_id, :radius => s.radius)
    end
  end
end