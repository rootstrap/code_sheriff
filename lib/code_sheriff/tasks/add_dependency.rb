# frozen_string_literal: true

module CodeSheriff
  module Tasks
    class AddDependency
      attr_reader :context, :dependency

      def initialize(context:, dependency:)
        @context = context
        @dependency = dependency
      end

      def add
        return if contains_gem?

        append_gemfile
        dependency.add_config_file(context)
      end

      private

      def gemfile
        @gemfile ||= File.read(context.gemfile_path)
      end

      def contains_gem?
        gemfile.match(Regexp.new("\ *gem\ *\'#{dependency.name}\'"))
      end

      def append_gemfile
        File.open(context.gemfile_path, 'a+') do |file|
          file.puts("#{dependency.gemfile_code}\n")
        end
      end
    end
  end
end
