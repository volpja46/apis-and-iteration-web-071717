def welcome
  # puts out a welcome message here!
  puts "Welcome to the Star Wars search engine! Here, you can enter a character's name, and you will see the movies in which that character appeared."
  puts "...give me a second while I generate the list of available characters for you to search..."
end

def show_list_of_available_characters(characters_array)
	puts "These are the available characters: #{characters_array.join(", ")}"
end

def get_character_from_user
  puts "Please enter a character:"
  # use gets to capture the user's input. This method should return that input, downcased.
  input = gets.chomp
  input.downcase
end

def continue?
	puts "Do you want to search again? (y/n)"
	gets.chomp
end