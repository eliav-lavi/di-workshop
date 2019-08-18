require 'types'
require 'dry-struct'

module Parka
  module Charge
    class Model < Dry::Struct
      attribute :check_in_id, Types::Strict::String
      attribute :amount, Types::Strict::Float
      attribute :created_at, Types::Strict::Time
    end
  end
end