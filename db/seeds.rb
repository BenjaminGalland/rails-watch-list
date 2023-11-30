# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-uri"

puts "Clear movies..."
Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
response = URI.open(url).read
response = JSON.parse(response)
results = response["results"]
results.each do |result|
  puts result["title"]
  Movie.create(
    title: result["title"],
    overview: result["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{result["poster_path"]}",
    rating: result["vote_average"].round(2)
  )
end
