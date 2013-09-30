#!/usr/bin/ruby

require 'rest_client'
require 'sqlite3'


def callRandom(small, large, count)
	db = SQLite3::Database.open "randInt.db"
	#call generator (web server)
	for i in 0..(count-1)
		response = RestClient.get 'localhost:4567/random/integer', {:params => {:min =>small, :max => large}}
		db.execute "INSERT INTO Random(min, max, result) VALUES(#{small}, #{large}, #{response.to_str})"
	end

    #close db connection
	rescue SQLite3::Exception => e
		puts "Exception occured"
		puts e

	ensure
		db.close if db
	return 0
end

def openTbl()
	db = SQLite3::Database.open "randInt.db"
    
    sql = db.prepare "SELECT * FROM Random" 
    results = sql.execute 
    
    results.each do |row|
        puts row.join "\s"
    end
           
	rescue SQLite3::Exception => e 
	    
	    puts "Exception occured"
	    puts e
	    
	ensure
	    sql.close if sql
	    db.close if db
end

begin
	puts 'This is a random number generator. The user will input the minimum and maximum integers to declare the range the generator can output. The user will also input the amount of times the generator will be called. The final results will be stored in a table, which will be displayed after last call to the generator is given.'
	puts ''
	puts 'Enter minimum value for range:'
	minI = gets.chomp
	minNum = minI.to_i
	puts 'Enter maximum value for range:'
	maxI = gets.chomp
	maxNum = maxI.to_i
	#ensure that the minimum number is less than the maximum number
	while maxNum <= minNum
		puts 'Max number is smaller than minimum number. Enter maximum value for range:'
		maxI = gets.chomp
		maxNum = maxI.to_i
	end
	puts 'Enter the number of random numbers you would like to be output:'
	count = gets.chomp
	count = count.to_i
	callRandom(minI, maxI, count)
	openTbl()
end