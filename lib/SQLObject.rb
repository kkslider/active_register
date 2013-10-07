require 'active_support/inflector'

class SQLObject < MassObject
  def self.table_name
    @current_table.pluralize.underscore
  end

  def self.all
    DBConnection.open(self.table_name)
    results = DBConnection.execute("select * from ?", "#{self.table_name}")
    results.each do |row|
      self.new(row)
    end
  end

  def self.set_table_name(table)
    @current_table = table 
  end
end

#sql = SQLObject.new

