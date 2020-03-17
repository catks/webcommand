module Webcommand
  class CLI < Thor
    SERVER_ADAPTERS = {
      'webrick' =>  Webcommand::Server::Adapters::Webrick
    }.freeze

    desc "server", "Start the Webcommand server"
    option :port, aliases: :p, default: 9292
    option :bind, aliases: :b, default: '0.0.0.0'
    option :adapter, type: :string, enum: SERVER_ADAPTERS.keys, default: 'webrick'

    def server
      server_adapter = SERVER_ADAPTERS[options[:adapter]]
      server = server_adapter.new(Webcommand::Server, options)

      server.start
    end
  end
end
