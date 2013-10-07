require 'active_support/inflector'

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
    result ? self.new(result.first) : nil
  end

  def create
    # attribute_values = 
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{self.class.attributes.join(', ')})
      VALUES
        (#{(['?'] * self.class.attributes.length).join(', ')})
    SQL
    
    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.attributes.map { |attr_name| "#{attr_name} = ?" }.join(", ")
    
    DBConnection.execute(<<-SQL, *attribute_values, self.id)
    UPDATE
    #{self.class.table_name}
    SET
    #{set_line}
    WHERE
    id = ?
    SQL
  end

  def save
    if !self.id
      create
    else
      update
    end
  end

  def attribute_values
    self.class.attributes.map { |attr_name| self.send(attr_name) }
  end
end
