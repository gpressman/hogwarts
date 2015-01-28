require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'

class Professor
	attr_accessor :rating
	def initialize(name, rating)
		@name = name
		@rating = 0
	end
	
	def thumbsup!
		@rating = 0
		@rating = @rating+1
		
	end 

	def thumbsdown!
		@rating=0
		@rating=@rating-1
	end

end

snape 	=    Professor.new(snape, 0)
mcgonn 	=   Professor.new(mcgonn, 0)
filtwick = Professor.new(filtwick, 0)
sprout =   Professor.new(sprout, 0)

sprout.thumbsdown!

puts sprout.rating
enable :sessions

set :session_secret, 'super secret'

professors= {"1" =>snape, "2" =>mcgonn, "3" =>filtwick, "4" =>sprout}

get '/thumbs_up/:id' do
	erb :thumbs_up	
end

get '/thumbs_down/:id' do 
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





