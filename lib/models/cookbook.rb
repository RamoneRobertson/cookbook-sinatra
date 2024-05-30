# TODO: Implement the Cookbook class that will be our repository
require 'csv'
require_relative 'recipe'

class Cookbook
  # initialize which creates an empty array to store your Recipe instances
  def initialize(csv_file_path)
    @recipes = []
    @csv_file = csv_file_path
    load_csv
  end

  # all which returns all the recipes
  def all
    @recipes
  end

  # create(recipe) which creates a recipe and adds it to the cookbook
  def create(recipe)
    @recipes << recipe
    save_csv
  end

  # destroy(recipe_index) which removes a recipe from the cookbook
  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  private

  def load_csv
    # Load the csv file, then create a Recipe instance for each row
    CSV.foreach(@csv_file) do |row|
      name = row[0]
      description = row[1]
      # Call the create method store new Instances in @recipes array
      create(Recipe.new(name, description))
    end
  end

  def save_csv
    # Open the CSV file for updating
    CSV.open(@csv_file, "wb") do |csv|
      # iterate through the @recipes aray
      @recipes.each do |recipe|
        # For each Recipe instance, add the name/description to a row in the csv file
        csv << [recipe.name, recipe.description]
      end
    end
  end
end
