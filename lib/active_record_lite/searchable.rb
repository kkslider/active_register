require_relative './db_connection'

module Searchable
  def where(params)
    keys_array = params.keys.map { |key| "#{key} = ?" }.join(" AND ")
    results = DBConnection.execute(<<-SQL, *params.values)
    SELECT
    *
    FROM
    #{self.table_name}
    WHERE
    #{keys_array}
    SQL
        
    self.parse_all(results)
  end
end