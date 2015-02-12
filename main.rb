require 'sinatra'
require 'sqlite3'
require 'rubygems'
require 'active_support/inflector'
require 'pry'

DATABASE = SQLite3::Database.new("inventory_management.db")

require_relative "models/database_setup"
require_relative "models/database_functions"
require_relative "models/category"
require_relative "models/product"
require_relative "models/shelf"

before "/new" do
  binding.pry
  if params[:type].nil?
    redirect to("/")
  end
  binding.pry
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
    @obj = Shelf.new(@result[0])
  when "product"
    @result = Product.search_for("id", params[:id])
    @obj = Product.new(@result[0])    
  when "category"
    @result = Category.search_for("id", params[:id])
    @obj = Category.new(@result[0])
  end
  erb :view
end

get "/create" do
  case params[:type]
  when "shelf"
    @req = Shelf.requirements
  when "product"
    @req = Product.requirements
    @shelf_list = Shelf.list_all
    @category_list = Category.list_all
  when "category"
    @req = Category.requirements
  end
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
  redirect to("/view?type=#{params[:type]}&id=#{@obj.id}")
end