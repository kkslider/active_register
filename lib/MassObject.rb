class MassObject
  #def self.all_attr
    #@attributes ||= []
  #end

  def self.attributes
    @attributes ||= []
  end

  def self.my_attr_accessible(*attributes)
    attributes.each do |attribute|
      attr_accessor(attribute)
    end
  end
end

class MyClass < MassObject
  my_attr_accessible :x, :y
end

my_obj = MyClass.new
my_obj.x = :x_val
my_obj.y = :y_val

p my_obj.x
p my_obj.y
