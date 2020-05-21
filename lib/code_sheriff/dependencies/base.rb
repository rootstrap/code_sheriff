# frozen_string_literal: true

module CodeSheriff
  module Dependencies
    class Base
      attr_reader :config_file_destination, :config_file_source, :name, :version

      def initialize(config_file_source: nil, config_file_destination: nil, name:,
                     version: nil)
        @config_file_source = config_file_source
        @config_file_destination = config_file_destination
        @name = name
        @version = version ? "'#{version}'" : nil
      end

      def add_config_file(context)
        if config_file_source
          File.open("#{context.folder_path}/#{config_file_destination}", 'w') do |file|
            file.puts config_file_source_content
          end
        end

        puts "\t#{name.capitalize} installed"
      end

      def gemfile_code
        "gem '#{name}', group: :development"
      end

      def gemspec_code
        "  spec.add_development_dependency '#{name}'"
      end

      private

      def config_file_source_content
        File.read(config_file_source)
      end
    end
  end
end
