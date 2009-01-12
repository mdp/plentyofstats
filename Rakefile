require 'rubygems'
require 'spec'
require 'db'

namespace :db do
  desc "Migrate the DB"
  task :migrate do
    DataMapper.auto_migrate!
  end
end