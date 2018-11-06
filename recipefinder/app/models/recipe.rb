#add a "for" class method
	#take a keyword to query
	#query the Food2Fork API for a result
	#add the HTTP query parameter key(=08de53fafdfd19022d9ea557dba3ccab)
		#to each outgoing URL request to http://food2fork.com/api
		#using HTTParty default_params
	#obtain the key value from an environment variable FOOD2FORK_KEY
	#obtain the url (and/or port) value from an environment variable
		#FOOD2FORK_SERVER_AND_PORT

#use http://food2fork.com/api host and port# (default=:80) during development
#and Heroku deployment
#However, your assignment wil be graded off-line and
#should get its host and port# from the FOOD2FORK_SERVER_AND_PORT environment
#variable. Your asignment must use the defined value if present
#and default to the real value otherwise

#Function:
	#display a recipe index page based on a search keyword
	#the user enters a search term
	#the app passes the query to http://food2fork.com/api
	#the app accept the results
	#the app builds a webpage display of the results
		#the app accepts the next search term
		#the page provides hyperlinks to detailed recipe from other websites
	#deploy your app to Heroku

class Recipe
	include HTTParty
	key_value = ENV["FOOD2FORK_KEY"]
	hostport = ENV["FOOD2FORK_SERVER_AND_PORT"] || "www.food2fork.com"
	base_uri "http://#{hostport}/api"
	default_params key: key_value
	format :json

	def self.for (term)
		get("/search", query: {q: term})["recipes"]
	end
end

