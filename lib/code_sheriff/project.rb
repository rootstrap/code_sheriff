# frozen_string_literal: true

module CodeSheriff
  class Project
    def create
      CodeSheriff::Context.new
    end
  end
end
