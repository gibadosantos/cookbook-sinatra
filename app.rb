require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path("..", __FILE__)
end

require_relative "cookbook"
require_relative "recipe"

file_path = File.join(__dir__, "recipes.csv")
cookbook = Cookbook.new(file_path)

get "/" do
  @recipes = cookbook.all
  erb :index
end

get "/new" do
  erb :new
end

post "/create" do
  name = params[:name]
  description = params[:description]
  recipe = Recipe.new(name, description)
  cookbook.add_recipe(recipe)
  redirect "/"
end

get "/recipe/:index" do
  recipe_index = params[:index].to_i
  cookbook.remove_recipe(recipe_index)
  redirect "/"
end
