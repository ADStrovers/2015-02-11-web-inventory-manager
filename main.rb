require 'sinatra'
require 'sqlite3'
require 'rubygems'
require 'active_support/inflector'
require 'pry'

DATABASE = SQLite3::Database.new("./database/inventory_management.db")

# models = Dir["./models/*.rb"]
# models.each do |file|
#   require_relative file
# end
require_relative "models/database_setup"
require_relative "models/database_functions"
require_relative "models/category"
require_relative "models/product"
require_relative "models/shelf"
require_relative "helpers/create_helper"
require_relative "helpers/path_redirect_helper"

helpers CreateHelper, PathRedirectHelper

before "/new" do
  if params[:type].nil?
    redirect to("/")
  end
end

before "/" do
  query_string = params.map{ |key, value| "#{key}=#{value}"}.join("&")
  case params[:action]
  when "create"
    redirect to("/create?#{query_string}")
  when "view"
    redirect to("/view?#{query_string}")
  when "modify"
    redirect to("/modify?#{query_string}")
  when "delete"
    redirect to("/delete?#{query_string}")
  end
end

get "/" do
  erb :homepage
end

get "/search" do
  
end

get "/modify" do
  
end

get "/delete" do
  
end

get "/view" do
  case params[:type]
  when "shelf"
    @result = Shelf.search_for("id", params[:id])
  when "product"
    @result = Product.search_for("id", params[:id])
  when "category"
    binding.pry
    @result = Category.search_for("id", params[:id])
  end
  @obj = @result[0]
  erb :view
end

get "/create" do
  case params[:type]
  when "shelf"
    @req = Shelf.requirements
  when "product"
    @req = Product.requirements
    @shelf_list = Shelf.all
    @category_list = Category.all
  when "category"
    @req = Category.requirements
  end
  @strings = create_helper(@req)
  erb :create
end

get "/new" do
  case params[:type]
  when "shelf"
    @obj = Shelf.new(params)
  when "product"
    @obj = Product.new(params)
  when "category"
    @obj = Category.new(params)
  end
  @obj.insert
  path_redirect("view")
end