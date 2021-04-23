module Messaging
  module Schema
    class SchemaFile
      class << self
        def call(event: 'create', version: 'current')
          new.call(event: event, version: version)
        end
      end

      private
      def initialize(schema_root: 'etc/schema', schema_path: '', schema_file: '')
        @schema_root=schema_root
        @schema_path=schema_path
        @schema_file=schema_file
      end

      def fully_qualified_filename(event:, version:)
        File.join(Rails.root, @schema_root, version.to_s, @schema_path, event.to_s, @schema_file)
      end

      public
      def call(event: 'create', version: 'current')
        fully_qualified_filename(event: event, version: version)
      end
    end
  end
end
