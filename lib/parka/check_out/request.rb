require 'types'
require 'dry-struct'

module Parka
  module CheckOut
    class Request < Dry::Struct
      attribute :check_in_id, Types::Strict::String
    end
  end
end