module Parka
  module Charge
    module Services
      class Calculator
        def self.build
          new
        end

        def call(check_in)
          checkout_time = Time.now
          stay_time_in_seconds = checkout_time - check_in.created_at
          rate_per_second = case check_in.vehicle_type
          when 'car'
            1
          when 'bus'
            1.5
          when 'truck'
            2
          end

          stay_time_in_seconds * rate_per_second
        end
      end
    end
  end
end