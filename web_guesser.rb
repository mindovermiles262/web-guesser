require 'sinatra'
require 'sinatra/reloader'

number = 1 + rand(99)

get '/' do
	guess = params['guess']
	cheater = params['cheater']
	message = check_guess(guess, number, cheater)
	erb :index, :locals => {:message => message}
end


private


def check_guess(guess, number, cheater)
	if cheater == "true"
		message = "The secret number is #{number} you cheater!"
	elsif guess != nil
		guess = guess.to_i
		message = get_message(guess, number)
	else
		message = "Guess a number 1 to 100"	
	end
end


def get_message(guess, number)
	if guess == number
		"You guessed it"
	elsif guess > number # guess is too high
		if guess - number > 5
			"Your guess is way too high!"
		else
			"Your guess is high"
		end
	else # guess is too low
		if number - guess > 5
			"Your guess is way too low"
		else
			"Your guess is low"
		end	
	end	
end
