require 'rest-client'
require 'json'
require 'pry'

# Returns an array of hashes about each move character has been in
def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

######## iterate over the character hash to find the collection of `films` for the given `character`
  # cuts data to just results of all characters on page
  all_character_data = character_hash["results"]
  
  # cuts data to give just info hash of our character to a variable
  specific_character_data = all_character_data.select do |hash|
    hash["name"].downcase == character
  end
  # returns films for our character in a variable
  specific_character_films = specific_character_data.first["films"]


######## collect those film API urls, make a web request to each URL to get the info for that film --- return value of this method should be collection of info about each film. i.e. an array of hashes in which each hash reps a given film ---this collection will be the argument given to `parse_character_movies` and that method will do some nice presentation stuff: puts out a list of movies by title. play around with puts out other info about a given film.
  specific_character_films.map do |film|
    film_info = JSON.parse(RestClient.get(film))
    film_info
  end
end

def parse_character_movies(films_hash)
  # some interation magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts "*" * 20
    puts film["title"]
    puts "Episode " + film["episode_id"].to_s
    puts film["director"]
    puts film["producer"]
    puts film["release_date"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## TESTING IF METHODS WORK TOGETHER
# luke_movies = get_character_movies_from_api("Luke Skywalker")
# parse_character_movies(luke_movies)
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
