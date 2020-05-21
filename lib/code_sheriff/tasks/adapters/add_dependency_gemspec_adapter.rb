# frozen_string_literal: true

module CodeSheriff
  module Tasks
    module Adapters
      class AddDependencyGemspecAdapter
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

        def gemspec
          @gemspec ||= File.read(context.gemspec_path)
        end

        def contains_gem?
          gemspec.match? Regexp.new("('|\")#{@dependency.name}('|\")")
        end

        def add_to_file
          gemspec_add_dependency
          write_to_gemspec
        end

        def write_to_gemspec
          File.open(context.gemspec_path, 'w') do |file|
            file.puts gemspec
          end
        end

        def gemspec_add_dependency
          gemspec.gsub!(/end\n\z/, "  #{dependency.gemspec_code}")
          gemspec << "\nend"
        end
      end
    end
  end
end
