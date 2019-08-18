require 'parka/db'

module Parka
  class RepoBase
    def initialize(db:, table_name:)
      @db = db
      @table_name = table_name
    end

    def create(record)
      @db.table(@table_name) << record
      record
    end

    def find_by(**kw)
      @db.table(@table_name).find { |record| record.attributes.merge(kw) == record.attributes }
    end

    def delete_by(**kw)
      @db.table(@table_name).tap { |table| table.delete(find_by(kw)) }
    end
  end
end