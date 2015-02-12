require 'minitest/autorun'
require 'sqlite3'
require 'rubygems'
require 'active_support/inflector'

DATABASE = SQLite3::Database.new("./database/inventory_management_test.db")
require_relative '../models/database_setup'

require_relative '../models/database_functions'
require_relative '../models/shelf'

class DatabaseMethodsTest < Minitest::Test
  
  def setup
    DATABASE.execute("DELETE FROM products")
    DATABASE.execute("DELETE FROM shelves")
    DATABASE.execute("DELETE FROM categories")
  end
  
  # Testing .insert
  
  def test_shelf_receives_id_when_inserted
    test = Shelf.new({"name" => "South-West"})
    test.insert
    
    assert_kind_of Integer, test.id
  end
  
  # Testing .all as well as initializing built on top of .insert passing before.
  
  def test_shelf_name_should_be_equal_to_passed_in_name
    test = Shelf.new({"name" => "North"})
    test.insert
    shelves = Shelf.all
    
    assert_equal "North", shelves[-1].name
  end
  
  def test_shelf_name_should_change_after_save
    test = Shelf.new({"name" => "West"})
    test.insert
    test.name = "North-West"
    test.save
    shelves = Shelf.all
    
    assert_equal "North-West", shelves[-1].name
  end
  
  def test_should_properly_delete_record_from_database
    DATABASE.execute("DELETE FROM shelves")
    test = Shelf.new({"name" => "East"})
    test.insert
    first_assert = Shelf.search_for("id", test.id)
    
    assert_equal first_assert[0].id, test.id
    
    Shelf.delete(test.id)
    second_assert = Shelf.search_for("id", test.id)
    
    assert_equal Array.new, second_assert
  end
end