require 'recipe_repository'
# require 'recipe'

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: 'localhost', dbname: 'recipes_directory_test'})
  connection.exec(seed_sql)
end

RSpec.describe RecipeRepository do
  before(:each) do
    reset_recipes_table
  end

  describe "#all" do
    it "returns list of populated Recipe objects" do
      repo = RecipeRepository.new
      recipes = repo.all
      expect(recipes.length).to eq 2
      expect(recipes.first.id).to eq '1'
      expect(recipes.first.name).to eq 'test meal 1'
      expect(recipes.first.cooking_time).to eq '15'
      expect(recipes.first.rating).to eq '3'
      expect(recipes[1].id).to eq '2'
      expect(recipes[1].name).to eq 'test meal 2'
      expect(recipes[1].cooking_time).to eq '20'
      expect(recipes[1].rating).to eq '4'
    end
  end

  describe "#find(id)" do
    it "returns populated Recipe object selected by id" do
      repo = RecipeRepository.new
      recipe = repo.find(2)
      expect(recipe.id).to eq '2'
      expect(recipe.name).to eq 'test meal 2'
      expect(recipe.cooking_time).to eq '20'
      expect(recipe.rating).to eq '4'
    end
  end
end