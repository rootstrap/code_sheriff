# frozen_string_literal: true

module CodeSheriff
  class Project
    attr_reader :context

    def initialize
      @context = CodeSheriff::Context.new
    end

    def install_dependencies
      brakeman = Dependencies::Brakeman
      CodeSheriff::Tasks::AddDependency.new(context: @context, project_type: project_type,
                                            dependency: brakeman).add
    end

    def project_type
      @project_type ||= is_gem? ? 'gem' : 'rails'
    end

    private

    def is_gem?
      Dir.glob('*.gemspec').first != nil
    end
  end
end
