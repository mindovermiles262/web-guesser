require 'sinatra'
require 'sinatra/reloader'

get '/' do
	number = rand(0..100)
	erb :index, :locals => {:number => number}
end