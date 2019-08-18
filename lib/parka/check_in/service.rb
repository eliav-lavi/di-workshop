require 'parka/check_in/model'
require 'parka/check_in/repo'
require 'securerandom'

module Parka
  module CheckIn
    class Service

      def self.build
        check_in_repo = CheckIn::Repo.build
        uuid_generator = SecureRandom
        new(check_in_repo: check_in_repo, uuid_generator: uuid_generator)
      end

      def initialize(check_in_repo:, uuid_generator:)
        @check_in_repo = check_in_repo
        @uuid_generator = uuid_generator
      end

      def call(request)
        check_in = create_check_in(request)
        @check_in_repo.create(check_in)
      end

      private

      def create_check_in(request)
        Parka::CheckIn::Model.new(request.attributes.merge(id: @uuid_generator.uuid, created_at: Time.now))
      end
    end
  end
end