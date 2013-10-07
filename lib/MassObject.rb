class MassObject
  def self.attributes
    @attributes ||= []
  end

  def initialize(params)
    params.each do |attr_name, value|
      if self.class.attributes.include?(attr_name)
        self.send("#{attr_name}=", value)
      else
        raise "mass assignment to unregistered attribute #{attr_name}"
      end
    end
  end

  def self.my_attr_accessible(*attributes)
    attributes.each do |attribute|
      self.attributes << attribute
      attr_accessor(attribute)
    end
  end
end

class MyClass < MassObject
  my_attr_accessible :x, :y
end

my_obj = MyClass.new(:x => :x_val, :y => :y_val)
p my_obj.x
p my_obj.y
