require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

DatabaseConnection.connect('recipes_directory')

repo = RecipeRepository.new

puts "#all output:"
recipes = repo.all
recipes.each do |recipe|
  puts "#{recipe.id} - #{recipe.name} - #{recipe.cooking_time} - #{recipe.rating}"
end

puts "\n#find(3) output:"
recipe = repo.find(3)
puts "#{recipe.id} - #{recipe.name} - #{recipe.cooking_time} - #{recipe.rating}"
