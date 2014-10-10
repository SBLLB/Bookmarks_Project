require './lib/link'
require './lib/user'
require './lib/tag'


env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

DataMapper.finalize

# DataMapper.auto_upgrade! - Removed that because we have made auto migrate and up-grade as we put a manual element in rake 