# frozen_string_literal: true

require 'code_sheriff/context'
require 'code_sheriff/version'
require 'code_sheriff/dependencies/base'
require 'code_sheriff/dependencies/brakeman'
require 'code_sheriff/tasks/add_dependency'

module CodeSheriff
  class Error < StandardError; end
  class Gem
    def create
      context = CodeSheriff::Context.new
      Tasks::AddDependency.new(context: context, dependency: Dependencies::Brakeman).add
    end
  end
end
