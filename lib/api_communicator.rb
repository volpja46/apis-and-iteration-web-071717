require 'rest-client'
require 'json'
require 'pry'

# web request returning an array of hashes full of character info
def get_characters_from_api
  #establish initial url from api
  url = 'http://www.swapi.co/api/people/'
  #get all data from first page of API
  page_of_characters = JSON.parse(RestClient.get(url))
  all_characters = page_of_characters
  
  next_call = page_of_characters["next"]

  while next_call do
    next_page = next_call
    next_page_of_characters = JSON.parse(RestClient.get(next_page))
    (all_characters["results"] << next_page_of_characters["results"])
    next_call = next_page_of_characters["next"]
  end

  all_characters
end

def get_list_of_all_character_names(array_of_hashes_of_characters)
  array_of_hashes_of_characters.map do |hash|
    hash["name"].downcase
  end
end

def valid_character?(character_array, character)
  character_array.include?(character)
end

# cuts data to just results of all characters on page
def remove_unnecessary_data(info_hash) 
  just_character_data = info_hash["results"].flatten
end

# cuts data to give just info hash of our character to a variable
def get_specific_character_data(removed_unnecessary_data, character)
  specific_character_data = removed_unnecessary_data.select do |hash|
    hash["name"].downcase == character
  end
end
  # returns films for our character in a variable
def get_movies_of_specific_character(specific_character_data)
  specific_character_films = specific_character_data.first["films"]
end

######## collect those film API urls, make a web request to each URL to get the info for that film --- return value of this method should be collection of info about each film.
def get_info_on_films(film_array) 
  film_array.map do |film|
    film_info = JSON.parse(RestClient.get(film))
    film_info
  end
end

###############################################################
#                          BEGIN                              #
# helper methods to be used in #parse_character_movies method #
#                                                             #
###############################################################

#get title of a film
def film_title(film)
  film["title"]
end

#get episode number of a film and turn it into a string instead of an int
def film_episode(film)
  film["episode_id"].to_s
end

#get director of film
def film_director(film)
  film["director"]
end

#get producer(s) of film
def film_producer(film)
    film["producer"].split(', ').join(" and ")
end

#get release date of film
def film_release_date(film)
  film["release_date"]
end

###############################################################
#                           END                               #
# helper methods to be used in #parse_character_movies method #
#                                                             #
###############################################################

#use helper methods to puts out well-formatted report of movies
def parse_character_movies(films_hash)
  films_hash.each do |film|
    puts "*" * 20
    puts "Title: #{film_title(film)}"
    puts "Episode: #{film_episode(film)}"
    puts "Director: #{film_director(film)}"
    puts "Producer(s): #{film_producer(film)}"
    puts "Release Date: #{film_release_date(film)}"
  end
end

def show_character_movies(character)
  all_character_hash = get_characters_from_api
  removed_extra_data = remove_unnecessary_data(all_character_hash)
  specific_character_data = get_specific_character_data(removed_extra_data, character)
  character_movie_data = get_movies_of_specific_character(specific_character_data)
  film_info = get_info_on_films(character_movie_data)
  parse_character_movies(film_info)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?



