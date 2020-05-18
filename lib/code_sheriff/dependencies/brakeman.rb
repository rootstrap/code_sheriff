# frozen_string_literal: true

module CodeSheriff
  module Dependencies
    Brakeman = Base.new(
      config_file_source: "#{File.dirname(__FILE__)}/../support/brakeman.yml",
      config_file_destination: '/config/brakeman.yml',
      name: 'brakeman'
    )
  end
end
