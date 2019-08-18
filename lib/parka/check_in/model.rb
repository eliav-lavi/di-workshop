require 'types'
require 'dry-struct'

module Parka
  module CheckIn
    class Model < Dry::Struct
      attribute :id, Types::Strict::String
      attribute :vehicle_type, Types::Strict::String
      attribute :created_at, Types::Strict::Time
    end
  end
end