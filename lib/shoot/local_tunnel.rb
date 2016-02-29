require 'childprocess'
require 'forwardable'
require 'securerandom'

module Shoot
  class LocalTunnel
    extend Forwardable
    def_delegators :@process, :start, :stop, :exited?

    def initialize(port = 3000)
      @process = ChildProcess.build("lt", "--subdomain=#{subdomain}", "--port=#{port.to_s}")
      start
    end

    def subdomain
      @subdomain ||= "shoot-#{Time.now.to_i}-#{SecureRandom.random_number(10**8)}"
    end

    def url
      @url ||= "https://#{subdomain}.localtunnel.me"
    end
  end
end
