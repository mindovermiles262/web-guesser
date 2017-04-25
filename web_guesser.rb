require 'sinatra'
require 'sinatra/reloader'

number = 1 + rand(99)
@@guesses_remaining = 6

get '/' do
	guess = params['guess']
	cheater = params['cheater']
	message = check_guess(guess, number, cheater)
	erb :index, :locals => {:message => message, :remaining_message => remaining_message}
end

get '/gameover' do
	"Game Over"
end


private


def remaining_message
	"You have #{@@guesses_remaining} guesses remaining!"
end


def check_guess(guess, number, cheater)

	@@guesses_remaining = @@guesses_remaining - 1

	if @@guesses_remaining > 0
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
		"You guessed it"
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