require_relative './associatable'
require_relative './db_connection'
require_relative './mass_object'
require_relative './searchable'

class SQLObject < MassObject
  def self.set_table_name(table_name)
    @current_table = table_name
  end

  def self.table_name
    @current_table.pluralize.underscore
  end

  def self.all
    #DBConnection.open(self.table_name)
    results = DBConnection.execute("select * from #{self.table_name}")
    results.each do |row|
      self.new(row)
    end
  end

  def self.find(id)
    #DBConnection.open(self.table_name)
    result = DBConnection.execute("select * from #{self.table_name} where id = ?", id)
    result ? result.first : nil
  end

  def create
    
  end

  def update
  end

  def save
  end

  def attribute_values
  end
end
