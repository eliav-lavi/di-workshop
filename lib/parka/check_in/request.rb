require 'types'
require 'dry-struct'

module Parka
  module CheckIn
    class Request < Dry::Struct
      VEHICLE_TYPES = %w(car truck bus)

      attribute :vehicle_type, Types::Strict::String.enum(*VEHICLE_TYPES)
    end
  end
end