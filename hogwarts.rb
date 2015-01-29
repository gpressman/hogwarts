require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'

class Professor
	attr_reader :name
	attr_accessor :rating
	def initialize(name, rating)
		@name = name
		@rating = 0
	end
	
	def thumbsup!
		@rating = @rating+1
		
	end 

	def thumbsdown!
		@rating=@rating-1
	end

end

snape 	=    Professor.new("Severus Snape", 0)
mcgonn 	=   Professor.new("Minerva McGonagall", 0)
filtwick = Professor.new("Phineas Flitwick", 0)
sprout =   Professor.new("Pomona Sprout", 0)

sprout.thumbsdown!

puts sprout.rating
enable :sessions

set :session_secret, 'super secret'

professors = {"1" =>snape, "2" =>mcgonn, "3" =>filtwick, "4" =>sprout}

post '/tally' do
	params.each do |id, value|
		if value=="up"
			professors[id].thumbsup!
		elsif value=="down"
			professors[id].thumbsdown!
		end

	end
	redirect to ('/results')
end

get '/results' do
	@professors=professors
	erb :hogwarts_results
end

get '/' do 
  erb :hogwarts_home

 end

get '/login' do
  erb :hogwarts_login

 end

get '/survey_page' do 

	@professors=professors
	erb :hogwarts_survey
end

get '/bad_login' do
	erb :bad_login
end


post '/authenticate' do
	if authenticate(params[:username], params[:password])
		redirect to ('/survey_page')
	else 
		redirect to ('/bad_login')

	end

end

def authenticate(username, password)
	users=[['harry', 'aaa'], ['ron', 'bbb'],['hermione', 'ccc']]
	puts "AAAAAAAAAAAAAAAAAA |#{username}|, |#{password}|" 
	if users.include?([username, password])
		return true
	
	else
		return false
	end
end





