require 'sinatra'
require 'sqlite3'
require 'rubygems'
require 'active_support/inflector'

DATABASE = SQLite3::Database.new("inventory_management.db")

require_relative "models/database_setup"
require_relative "models/database_functions"
require_relative "models/category"
require_relative "models/product"
require_relative "models/shelf"

before "/" do
  query_string = params.map{ |key, value| "#{key}=#{value}"}.join("&")
  case params[:action]
  when "create"
    redirect to("/create?#{query_string}")
  when "view"
    
  when "modify"
    
  when "delete"
    
  end
end

get "/" do
  erb :homepage
end

get "/results" do
  # Get param with category/product/shelf and redirect the erb call based on that information.
  # Should allow me to display results for each type in this one spot.
end

get "/modify" do
  
end

get "/delete" do
  
end

get "/view" do
  erb :view
end

get "/create" do
  case params[:type]
  when "shelf"
    @req = Shelf.requirements
  when "product"
    @req = Product.requirements
  when "category"
    @req = Category.requirements
  end
  erb :create
end