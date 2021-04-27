module Ecf
  module Messaging
    class Mapper
    attr_reader :name

      class << self
        def call(name, map, object)
          new(name).call(map,object)
        end
      end


      def messaging_class(klass)
        begin
          "::Ecf::Messaging::#{klass}".constantize
        rescue NameError=>e
          ::Ecf::Messaging::Mapper
        end
      end

      def initialize(name)
        self.name=name
      end
    end
  end
end
