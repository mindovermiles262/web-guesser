require 'sinatra'
require 'sinatra/reloader'

get '/' do
	"The Secret Number is #{rand(0..100)}!"
end