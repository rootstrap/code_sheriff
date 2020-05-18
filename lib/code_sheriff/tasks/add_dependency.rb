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

        if has_development_group?
          squished_lines = gemfile.map { |line| line.gsub(/\s+/, " ").strip }
          index = squished_lines.index('group :development do')
          gemfile.insert index + 1, "  gem '#{dependency.name}'\n"
        else
          gemfile.concat ["\ngroup :development do\n", "  gem '#{dependency.name}'\n", "end\n"]
        end
        write_gemfile
        dependency.add_config_files(context)
      end
      
      private

      def gemfile
        return @lines if @lines

        File.open(context.gemfile_path, 'r') do |file|
          @lines ||= file.each_line.to_a
        end
      end

      def contains_gem?
        gemfile.any? { |line| Regexp.new("\ *gem\ *\'#{dependency.name}\'") =~ line }
      end

      def write_gemfile
        File.open(context.gemfile_path, 'w') do |file|
          file.write(gemfile.join)
        end
      end

      def has_development_group?
        gemfile.any? { |line| /\ *group\ *\:development\ *do\ */ =~ line }
      end
    end
  end
end
