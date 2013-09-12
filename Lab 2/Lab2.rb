#Kyle Howell
#9/11/13
#CSCI 3308
#


# Part1: Hello World
class HelloWorldClass
    def initialize(name)
       @name = name.capitalize
    end
    def sayHi
        puts "Hello #{@name}!"
    end
end
hello = HelloWorldClass.new("Person")
hello.sayHi


#Part2a: Palindromes
def palindrome?(string)
    # your code here
    string.downcase!
    strrev = string.reverse
    string.gsub!(/[^a-z]/, "")
    strrev.gsub!(/[^a-z]/, "")
    return string == strrev
end

puts palindrome?("asdf")		
puts palindrome?("assa")							  # => true
puts palindrome?("race car")						  # => true
puts palindrome?("A man, a plan, a canal -- Panama")  # => true
puts palindrome?("Madam, I'm Adam!")                  # => true
puts palindrome?("Abracadabra")  

 
#Part2b: Word Hashes
def count_words(string)
    # your code here
    string.downcase!
    string.gsub!(/[^a-z ]/, "")
    puts string
    array = string.split(/\b {1,}/)
    hash = Hash.new
    array.each do |element|
		if(!hash.has_key?(element))
			hash[element] = 0
		end
		hash[element] += 1
	end
    return hash
end

puts count_words("A man, a plan, a canal --        Panama")
puts count_words "Doo bee doo bee doo"

#Part3a: Rock, Paper, Scissors
class WrongNumberOfPlayersError <  StandardError ; end
class NoSuchStrategyError <  StandardError ; end

def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2
    # your code here
    raise NoSuchStrategyError unless (game[0][1] =~ /[rpsRPS]/ and game[1][1] =~ /[rpsRPS]/)
    if(game[0][1].downcase ==  game[1][1].downcase)
		#easy case of tie
		print "Tie\n"
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
	print "No cases were met: #{game[0][1] =~ /[rR]/}\n"
end
puts rps_game_winner([ ["First", "r"], ["Second", "p"] ]) # Dave would win since S > P

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
	if(!tournament[0].kind_of?(Array))
		return #tournament = rps_game_winner(tournament)
	else
		rps_tournament_winner(tournament[0])
		rps_tournament_winner(tournament[1])
	end
end

puts rps_tournament_winner(tourny)

#Part4: Anagrams
def combine_anagrams(words)
    # your code here
    sorted = [] #contains the sorted words (no repeats)
    ret_array = []
    words.each do |word|
    #for each word, see if theres one already in the anagram array, otherwise, add to new slot
		sorted_temp = word.chars.sort_by(&:downcase).join
		sorted.each_with_index do |sorted_word, index| 
			if(sorted_word == sorted_temp)
				#no need to keep a duplicate in sorted array
				ret_array[index].push(word)
			else
				#doesn't exist yet so create a new array
				sorted.push(sorted_temp)
				ret_array.push([word])
			end
		end
    end
    return ret_array
end
puts "vfcdbhjm".chars.sort_by(&:downcase).join
input = ['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream']
#puts input
puts combine_anagrams(input).length
