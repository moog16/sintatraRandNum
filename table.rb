#!/usr/bin/ruby

require 'sqlite3'

begin
	db = SQLite3::Database.new("randInt.db")

	db.execute "CREATE TABLE IF NOT EXISTS Random(Id INTEGER PRIMARY KEY AUTOINCREMENT, min TEXT, max TEXT, result TEXT)"
	
rescue SQLite3::Exception => e
	puts "Exception occrued"
	puts e
ensure
	db.close if db
end
