require 'data_mapper'
require './app/data_mapper_setup'

task :auto_upgrade do 
	DataMapper.auto_upgrade!
	puts "Auto upgrade complete. No data loss"
end
	
	# auto_upgrade makes non-destructive changes.
	# If your tables don't exist, they will be created
	# but if they do and you changed your schema
	# (e.g. changed the type of one of the properties)
	# they will not be upgraded because that'd lead to data loss.

task :auto_migrate do 
	DataMapper.auto_migrate!
	puts "Auto migrate complete. Data could have been lost"
end

	# To force the creation of all tables as they are
	# described in your models, even if this
	# may lead to data loss, use auto_migrate: