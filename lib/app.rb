require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "csv"
require_relative "models/cookbook"

get "/" do
  cookbook = Cookbook.new(File.join(__dir__, "recipes.csv"))
  @recipes = cookbook.all
  erb :index
end

get "/add_recipe" do
  erb :add_recipe
end

post "/recipes" do
  cookbook = Cookbook.new(File.join(__dir__, "recipes.csv"))
  new_recipe = Recipe.new(params[:name], params[:description])
  cookbook.create(new_recipe)
  redirect to "/"
end

get "/recipes/:index" do
  cookbook = Cookbook.new(File.join(__dir__, "recipes.csv"))
  cookbook.destroy(params[:index].to_i)
  redirect to "/"
end
