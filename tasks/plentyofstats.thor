class Db < Thor                                                
  require 'db'
  desc "migrate", "Creates a new DB and erases the old"
  def migrate
    puts "Successfully migrated the DB" if DataMapper.auto_migrate!
  end
end