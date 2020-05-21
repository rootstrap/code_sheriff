# frozen_string_literal: true

module CodeSheriff
  class Context
    def gemfile_path
      "#{folder_path}/Gemfile"
    end

    def gemspec_path
      "#{folder_path}/#{Dir.glob('*.gemspec').first}"
    end

    def folder_path
      `pwd`.sub("\n", '/')
    end
  end
end
