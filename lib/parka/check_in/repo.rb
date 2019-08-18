require 'parka/db'
require 'parka/repo_base'

module Parka
  module CheckIn
    class Repo < RepoBase
      def self.build
        new(db: Parka::Db.instance, table_name: :check_in)
      end
    end
  end
end