class MassObject
  def self.my_attr_accessible(*attributes)
    @attributes = attributes.map { |attr_name| attr_name.to_sym }
    
    attributes.each do |attribute|
      # self.attributes << attribute
      attr_accessor(attribute)
    end
  end

  def self.attributes
    # @attributes ||= []
    @attributes
  end

  def self.parse_all(results)
    [].tap do |parsed_objs|
      results.each do |result|
        parsed_objs << self.new(result)
      end
    end
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      if self.class.attributes.include?(attr_name.to_sym)
        self.send("#{attr_name.to_sym}=", value)
      else
        raise "mass assignment to unregistered attribute #{attr_name.to_sym}"
      end
    end
  end
end
