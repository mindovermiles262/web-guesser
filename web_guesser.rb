require 'sinatra'
require 'sinatra/reloader'

number = 1 + rand(99)
@@guesses_remaining = 11


get '/' do
	guess = params['guess']
	cheater = params['cheater']
	message = check_guess(guess, number, cheater)
	color = get_color(guess.to_i - number)
	erb :index, :locals => {:message => message, 
							:remaining_message => remaining_message,
							:color => color }
end

get '/gameover' do
	erb :gameover
end

get '/winner' do
	erb :winner, :locals => {:number => number}
end


private


def get_color(difference)
	if difference == 0
		"green"
	elsif difference.between?(1,5) || difference.between?(-5,-1)
		"#ff7f7f"
	else
		"red"
	end
end



def remaining_message
	@@guesses_remaining = @@guesses_remaining -  1
	"You have #{@@guesses_remaining} guesses remaining!"
end


def check_guess(guess, number, cheater)
	if @@guesses_remaining > 1
		if cheater == "true"
			message = "<h1>The secret number is #{number} you cheater!</h1>"
		elsif guess != nil
			guess = guess.to_i
			message = get_message(guess, number)
		else
			message = "Guess a number 1 to 100"	
		end
	else
		redirect '/gameover'
	end
end


def get_message(guess, number)
	if guess == number
		redirect '/winner'
		# "Winner!"
	elsif guess > number # guess is too high
		if guess - number > 5
			"#{guess} is way too high!"
		else
			"#{guess} is high"
		end
	else # guess is too low
		if number - guess > 5
			"#{guess} is way too low"
		else
			"#{guess} is low"
		end	
	end	
end