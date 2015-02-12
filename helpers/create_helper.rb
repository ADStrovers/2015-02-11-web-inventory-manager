module CreateHelper
  def create_helper(array)
    string_array = []
    array.each do |x|
      string_array << "<p><label for=\"#{x}\">#{x.capitalize}:</label>"
      case x 
      when "name", "description"
        string_array << "<input type=\"text\" name=\"#{x}\"></p>"
      when "price", "quantity"
        string_array << "<input type=\"number\" name=\"#{x}\"></p>"
      when "shelf_id"
        string_array << "<select name=\"shelf_id\">"
        @shelf_list.each do |location|
          string_array << "<option class=\"center\" value=\"#{location.id}\">#{location.id} - #{location.name}</option>"
        end
        string_array << "</select></p>"
      when "category_id"
        string_array << "<select name=\"category_id\">"
        @category_list.each do |category|
          string_array << "<option class=\"center\" value=\"#{category.id}\">#{category.id} - #{category.name}</option>"
        end
        string_array << "</select></p>"
      end
    end
    string_array
  end
end