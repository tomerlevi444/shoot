module Shoot
  class LocalTunnelPow < LocalTunnel
    def initialize(server)
      `echo "export POW_EXT_DOMAINS=localtunnel.me" > ~/.powconfig`
      @process = ChildProcess.build("lt", "--port=80", "--subdomain=#{subdomain}")
      start
    end
  end
end
