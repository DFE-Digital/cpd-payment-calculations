require_relative '../../contracts/ecf/contract_class_name_factory'

module Services
  module Ecf
    class FromContract
      class << self
        def call(name, value)
          klass=ContractClassNameFactory.call(name).constantize
          klass.constantize.send(value)
        end
      end
    end
  end
end
