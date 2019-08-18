require 'parka/check_in/repo'
require 'parka/charge/services/calculator'
require 'parka/charge/repo'
require 'parka/charge/model'

module Parka
  module CheckOut
    class Service
      def self.build
        check_in_repo = Parka::CheckIn::Repo.build
        charge_calculator = Parka::Charge::Services::Calculator.build
        charge_repo = Parka::Charge::Repo.build

        new(check_in_repo: check_in_repo, charge_calculator: charge_calculator,
          charge_repo: charge_repo)
      end

      def initialize(check_in_repo:, charge_calculator:, charge_repo:)
        @check_in_repo = check_in_repo
        @charge_calculator = charge_calculator
        @charge_repo = charge_repo
      end

      def call(request)
        check_in = @check_in_repo.find_by(id: request.check_in_id)
        return :check_in_not_found if check_in.nil?

        puts "check in is: #{check_in}"
        amount_to_charge = @charge_calculator.call(check_in)
        puts "amount_to_charge is: #{amount_to_charge}"
        charge_model = Parka::Charge::Model.new(check_in_id: check_in.id,
          amount: amount_to_charge, created_at: Time.now)
        @charge_repo.create(charge_model)
        @check_in_repo.delete_by(id: check_in.id)

        :ok
      end
    end
  end
end