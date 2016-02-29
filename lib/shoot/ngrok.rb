require 'childprocess'
require 'forwardable'
require 'securerandom'

module Shoot
  class Ngrok
    extend Forwardable
    def_delegators :@process, :start, :stop, :exited?

    def initialize(port = 3000)
      @process = ChildProcess.build("ngrok", "-log=stdout", port.to_s)
      reader,writer = IO.pipe
      @process.io.stdout = writer

      start.tap do
        while @url.nil? || @url.empty? do 
          @url = reader.readline.match(/http:\/\/[a-z0-9A-Z]+.ngrok.com/).to_s
        end
      end
    end

    def subdomain
      @subdomain ||= "shoot-#{Time.now.to_i}-#{SecureRandom.random_number(10**8)}"
    end

    def url
      @url
    end
  end
end
