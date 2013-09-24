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

puts "\n\n"
puts "Part 3a Test"
puts "------------------------------------------------"
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
	if(tournament[0][0].kind_of?(Array))
		tournament[0] = rps_tournament_winner(tournament[0])
		
	end
	if(tournament[1][0].kind_of?(Array))
		tournament[1] = rps_tournament_winner(tournament[1])
	end
	#puts "Tournament is now: #{tournament}"
	return rps_game_winner(tournament)
end

puts "\n\n"
puts "Part 3b Test"
puts "------------------------------------------------"
puts rps_tournament_winner(tourny)






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

puts "\n\n"
puts "Part 4 Test"
puts "------------------------------------------------"
input = ['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream']
puts "#{combine_anagrams(input)}"



#Part1a: Classes
class Dessert
    def initialize(name, calories)
		@name = name
		@calories = calories
    end

    def healthy?
        return @calories < 200
    end

    def delicious?
        return true
    end
end

puts "\n\n"
puts "Part 1a Test"
puts "------------------------------------------------"
brownie = Dessert.new("brownie", 200)
icecream = Dessert.new("icecream", 180)
puts "Is brownie healthy? #{brownie.healthy?}"
puts "Is icecream healthy? #{icecream.healthy?}"

#Part1b: Classes
class JellyBean < Dessert
	attr_accessor :flavor
    def initialize(name, calories, flavor)
        @flavor = flavor
    end

    def delicious?
        return "black licorice" != flavor.downcase
    end
end

puts "\n\n"
puts "Part 1b Test"
puts "------------------------------------------------"
lemon = JellyBean.new("Lemon", 1, "Lemon")
puts "Is lemon delicious? #{lemon.delicious?}"

bl = JellyBean.new("BL", 1, "Black Licorice")
puts "Is black licorice delicious? #{bl.delicious?}"

#Part2: OOP
class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s       # make sure it's a string
        attr_reader attr_name            # create the attribute's getter
        attr_reader attr_name+"_history" # create bar_history getter
        class_eval %Q"
            def #{attr_name}=(value)
				if !defined?(@#{attr_name}_history)
					@#{attr_name}_history = [nil]
				end
                @#{attr_name} = value
                @#{attr_name}_history.push(value)
            end
        "
    end
end

class Foo
    attr_accessor_with_history :bar
end



puts "\n\n"
puts "Part 2 Test"
puts "------------------------------------------------"
f = Foo.new
f.bar = 1
f.bar = 2
g = Foo.new
f.bar = 4
puts "#{f.bar_history}"# => if your code works, should be [nil, 1, 2, 4]


#Part 3a: Currency conversion.
class Numeric
	@@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
	def method_missing(method_id)
		singular_currency = method_id.to_s.gsub( /s$/, '')
		if @@currencies.has_key?(singular_currency)
			self * @@currencies[singular_currency]
		else
			super
		end
	end
	
	def in(currency)
		singular_currency = currency.to_s.gsub( /s$/, '')
		if(@@currencies.has_key?(singular_currency))
			self / @@currencies[singular_currency]
		end	
	end
end

puts "\n\n"
puts "Part 3a Test"
puts "------------------------------------------------"
puts 5.dollars.in(:euros)
puts 10.euros.in(:rupees)
puts 1.dollar.in(:rupees)
puts 10.rupees.in(:euro)
puts 10.dollar.in(:dollars)


#Part 3b: Palindromes
class String
	def palindrome?
		temp = self.downcase.gsub(/[^0-9a-z]/, '')
		temp == temp.reverse
	end
end
puts "\n\n"
puts "Part 3b Test"
puts "------------------------------------------------"

puts "foo".palindrome?
puts "race car".palindrome?
puts "!@#%@#%^123race !@#!@#  ;;        car321".palindrome?


#Part 3c: Palindromes again
module Enumerable
	def palindrome?
		temp =[]
		self.each {|elt| temp << elt}
		temp == temp.reverse
	end
end
puts "\n\n"
puts "Part 3b Test"
puts "------------------------------------------------"

puts (1..5).palindrome?
puts [1,0,1].palindrome?
puts [" ", 12, 2 ,12, " "].palindrome?




#Part 4: Blocks
class CartesianProduct
    include Enumerable
    
    def initialize(coll1, coll2)
		@product = []
		coll1.each {|elt1| coll2.each {|elt2| @product << [elt1, elt2]}}
    end
    def each
		@product.each {|elt| yield elt}
    end
end

puts "\n\n"
puts "Part 4 Test"
puts "------------------------------------------------"
c = CartesianProduct.new([:a,:b], [4,5])
c.each {|elt| puts elt.inspect}
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]
c = CartesianProduct.new([:a,:b], [])
c.each {|elt| puts elt.inspect}
# nothing
