require_relative './db_connection'

module Searchable
  def where(params)
    keys_array = params.keys.map { |key| "#{key} = ?" }
    DBConnection.execute(<<-SQL, *params.values)
    SELECT
    *
    FROM
    #{self.class.table_name}
    WHERE
    (#{keys_array})
    SQL
  end
end