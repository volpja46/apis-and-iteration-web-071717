#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

def run
	welcome
list_of_available_characters = get_list_of_all_character_names(remove_unnecessary_data(get_characters_from_api))
show_list_of_available_characters(list_of_available_characters)
character = get_character_from_user

character_check = valid_character?(list_of_available_characters, character) 
	
until character_check
	puts "That's not a valid character. Please try again."
	character = get_character_from_user
	character_check = valid_character?(list_of_available_characters, character)
end

puts "Ok. Now, please be patient while I look up #{character}'s movies..."
show_character_movies(character)

continue_prompt = continue?

	if continue_prompt == "y"
		run
	else
		exit
	end

end

run
