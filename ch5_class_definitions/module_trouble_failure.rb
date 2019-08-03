module MyModule
  def self.my_method; 'hello'; end
end

class MyClass
  include MyModule
end

MyClass.my_method # NoMethodError
# How to add a class method by including a module?
