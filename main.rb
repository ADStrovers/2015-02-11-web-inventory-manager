require 'sinatra'
require 'sqlite3'
require 'rubygems'
require 'active_support/inflector'

Dir["/models/*.rb"].each {|file| require file }

DATABASE = SQLite3::Database.new("inventory_management.db")

before do
  erb :homepage
end

get "/" do
end