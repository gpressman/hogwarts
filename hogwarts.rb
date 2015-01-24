require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'

enable :sessions

set :session_secret, 'super secret'


get '/' do 
  erb :hogwarts_home

 end

get '/login' do
  erb :hogwarts_login

 end

get '/survey_page' do 
	erb :hogwarts_survey

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
