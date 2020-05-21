# frozen_string_literal: true

module CodeSheriff
  module Tasks
    class AddDependency
      attr_reader :context, :dependency, :project_type, :adapter

      def initialize(context:, project_type:, dependency:)
        @context = context
        @dependency = dependency
        @project_type = project_type
        @adapter = choose_adapter.new(@context, @dependency)
      end

      def add
        @adapter.add
      end

      private

      def choose_adapter
        return CodeSheriff::Tasks::Adapters::AddDependencyGemspecAdapter if @project_type == 'gem'

        CodeSheriff::Tasks::Adapters::AddDependencyGemfileAdapter
      end
    end
  end
end
