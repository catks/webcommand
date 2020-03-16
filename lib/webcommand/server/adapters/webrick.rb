module Webcommand
  class Server
    module Adapters
      class Webrick
        def initialize(server, options)
          require 'webrick'
          @server = server
          @options = options
        end

        def start
          server = WEBrick::HTTPServer.new(
            Port: @options[:port],
            BindAddress: @options[:bind])
          server.mount "/", Rack::Handler::WEBrick, server
          Signal.trap(:INT) { server.shutdown }
          server.start
        end
      end
    end
  end
end
 
