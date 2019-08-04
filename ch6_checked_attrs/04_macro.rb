require 'test/unit'

class Class
  def attr_checked(attribute, &validation)
    define_method attribute do
      instance_variable_get "@#{attribute}"
    end

    define_method "#{attribute}=" do |value|
      raise 'Invalid attribute' unless value && validation.call(value)
      instance_variable_set "@#{attribute}", value
    end
  end
end

class Person
  attr_checked :age do |v|
    v >= 18
  end
end

class TestCheckedAttribute < Test::Unit::TestCase
  def setup
    #add_checked_attribute(Person, :age) {|v| v >= 18 }
    @bob = Person.new
  end

  def test_accepts_valid_values
    @bob.age = 20
    assert_equal 20, @bob.age
  end

  def test_refuses_nil_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = nil
    end
  end

  def test_refuses_false_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = false
    end
  end
end
