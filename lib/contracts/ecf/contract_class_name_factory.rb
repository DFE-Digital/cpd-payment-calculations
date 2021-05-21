# frozen_string_literal: true

module Contracts
  module Ecf
    class ContractClassNameFactory
      class << self
        def call(name)
          contract_klass(name)
        end

        private
        def namespace_lookup
          {
          }
        end

        def default_namespace(name)
          "Contracts::Ecf::#{name.camelize}"
        end

        def namespace(name)
          namespace_lookup[name.intern] || default_namespace(name)
        end

        def contract_klass(name)
          "#{namespace(name)}::Contract"
        end
      end
    end
  end
end
