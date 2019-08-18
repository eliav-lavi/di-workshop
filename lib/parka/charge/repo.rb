require 'parka/db'
require 'parka/repo_base'

module Parka
  module Charge
    class Repo < RepoBase
      def self.build
        new(db: Parka::Db.instance, table_name: :charge)
      end
    end
  end
end