class Person; end

def add_checked_attribute(klass, attribute)
  klass.class_eval do
    define_method "#{attribute}" do
      instance_variable_get "@#{attribute}"
    end

    define_method "#{attribute}=" do |value|
      raise 'Invalid attribute' unless value
      instance_variable_set "@#{attribute}", value
    end
  end
end
