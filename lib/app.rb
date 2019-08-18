require 'roda'
require 'json'
require 'parka/db'
require 'dry-struct'

require 'parka/check_in/request'
require 'parka/check_in/service'
require 'parka/check_out/request'
require 'parka/check_out/service'

class App < Roda
  plugin :json, classes: [Array, Hash, Dry::Struct]

  route do |r|
    r.post 'check_in' do
      body = JSON.parse(r.body.read).transform_keys(&:to_sym)
      dry = Parka::CheckIn::Request.new(body)
      response = Parka::CheckIn::Service.build.call(dry)
      puts "db state: #{Parka::Db.instance.inspect}"
      puts "*****"

      { data: response.attributes }
    rescue StandardError => e
      puts "ERROR: #{e.message} | backtrace: #{e.backtrace}"
      { error: e.message, backtrace: e.backtrace }
    end

    r.post 'check_out' do
      body = JSON.parse(r.body.read).transform_keys(&:to_sym)
      dry = Parka::CheckOut::Request.new(body)
      response = Parka::CheckOut::Service.build.call(dry)
      puts "db state: #{Parka::Db.instance.inspect}"
      puts "*****"

      { data: response }
    rescue StandardError => e
      puts "ERROR: #{e.message} | backtrace: #{e.backtrace}"
      { error: e.message, backtrace: e.backtrace }
    end
  end
end