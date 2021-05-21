module DeclarativeConstants
  class << self
    def included(base)
      class_eval do
        base.extend BaseClassMethods
      end
    end
  end

  module BaseClassMethods
    def declarative_constants(*arr)
      return @declaritive_constants if arr.empty?
      attr_accessor(*arr)
      arr.each do |a|
        singleton_class.instance_eval do
          define_method(a) do |value|
            @declarative_constants ||= {}
            @declarative_constants[a] = value
          end
        end
      end

      class_eval do
        define_method(:initialize) do
          self.class.declarative_constants.each do |k, v|
            instance_variable_set("@#{k}", v)
          end
        end
      end
    end
  end
end
