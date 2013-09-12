#Kyle Howell
#9/11/13
#CSCI 3308
#https://github.com/kylelyk/CSCI-3308-Labs/tree/master/Lab%202


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

