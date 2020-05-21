# frozen_string_literal: true

module CodeSheriff
  module Tasks
    module Adapters
      class AddDependencyGemfileAdapter
        attr_reader :context, :dependency

        def initialize(context, dependency)
          @context = context
          @dependency = dependency
        end

        def add
          return if contains_gem?

          add_to_file
          dependency.add_config_file(context)
        end

        private

        def contains_gem?
          gemfile.match(Regexp.new("\ *gem\ *\'#{dependency.name}\'"))
        end

        def gemfile
          @gemfile ||= File.read(context.gemfile_path)
        end

        def add_to_file
          File.open(context.gemfile_path, 'a+') do |file|
            file.puts("#{dependency.gemfile_code}\n")
          end
        end
      end
    end
  end
end
