#Kyle Howell
#9/11/13
#CSCI 3308
#https://github.com/kylelyk/CSCI-3308-Labs/tree/master/Lab%202



#Part3a: Rock, Paper, Scissors
class WrongNumberOfPlayersError <  StandardError ; end
class NoSuchStrategyError <  StandardError ; end

def rps_game_winner(game)
	#puts "Determining winner of this game: #{game}\n\n"
    raise WrongNumberOfPlayersError unless game.length == 2
    # your code here
    raise NoSuchStrategyError unless (game[0][1] =~ /[rpsRPS]/ and game[1][1] =~ /[rpsRPS]/)
    if(game[0][1].downcase ==  game[1][1].downcase)
		#easy case of tie
		#print "Tie\n"
		return [game[0][0], game[0][1]]
    elsif(game[0][1] =~ /[rR]/)
		if(game[1][1] =~ /[Ss]/)
			return [game[0][0], game[0][1]]#Rock beats scissors
		else
			return [game[1][0], game[1][1]]#Paper beats rock
		end
	elsif(game[0][1] =~ /[sS]/)
		if(game[1][1] =~ /[rR]/)
			return [game[1][0], game[1][1]]#Rock beats scissors
		else
			return [game[0][0], game[0][1]]#Scissors beats paper
		end
	elsif(game[0][1] =~ /[Pp]/)
		if(game[1][1] =~ /[Ss]/)
			return [game[1][0], game[1][1]]#Scissors beats paper
		else
			return [game[0][0], game[0][1]]#Paper beats rock
		end
	end
	#print "No cases were met: #{game[0][1] =~ /[rR]/}\n"
end
puts rps_game_winner([ ["First", "r"], ["Second", "p"] ]) # Dave would win since S > P
puts "\n\n"
#Part3b: Rock, Paper, Scissors
tourny =[
    [
        [ ["Armando", "P"], ["Dave", "S"] ],
        [ ["Richard", "R"],  ["Michael", "S"] ]
    ],
    [
        [ ["Allen", "S"], ["Omer", "P"] ],
        [ ["David E.", "R"], ["Richard X.", "P"] ]
    ]
]
def rps_tournament_winner(tournament)
	#no nested left
	if(tournament[0][0].kind_of?(Array))
		tournament[0] = rps_tournament_winner(tournament[0])
		
	end
	if(tournament[1][0].kind_of?(Array))
		tournament[1] = rps_tournament_winner(tournament[1])
	end
	#puts "Tournament is now: #{tournament}"
	return rps_game_winner(tournament)
end

puts rps_tournament_winner(tourny)
puts "\n\n"

#Part4: Anagrams
def combine_anagrams(words)
    # your code here
    sorted = [] #contains the sorted words (no repeats)
    ret_array = []
    words.each do |word|
    #for each word, see if theres one already in the anagram array, otherwise, add to new slot
		puts "Now analyzing word: #{word}"
		sorted_temp = word.chars.sort_by(&:downcase).join
		found = false
		sorted.each_with_index do |sorted_word, index| 
			if(sorted_word == sorted_temp)
				#no need to keep a duplicate in sorted array
				puts "#{word} is already present, adding to index #{index}"
				ret_array[index].push(word)
				found = true
				break
			end
		end
		
		#doesn't exist yet so create a new array
		if(!found)
			sorted.push(sorted_temp)
			ret_array.push([word])
			puts "#{word} is not already present, creating new index at #{ret_array.length}"
		end
    end
    return ret_array
end

input = ['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream']
#puts input
puts "#{combine_anagrams(input)}"
