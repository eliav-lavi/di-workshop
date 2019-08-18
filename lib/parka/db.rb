require 'singleton'

module Parka
  class Db
    include Singleton

    def initialize
      @tables = {}
    end
    
    def table(name)
      @tables[name] ||= []
    end

    def inspect
      @tables
    end
  end
end