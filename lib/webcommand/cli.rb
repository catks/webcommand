module Webcommand
  class CLI < Thor
    desc "server", "Start the Webcommand server"
    option :port, aliases: :p, default: 9292
    option :bind, aliases: :b, default: '0.0.0.0'
    option :threads, aliases: :t, default: 8
    option :workers, aliases: :w, default: 1
    def server
      exec "puma " \
       "-p #{options[:port]} " \
       "-t #{options[:threads]}:#{options[:threads]} " \
       "-w #{options[:workers]} " \
       "#{Webcommand.root_path.join('config.ru')}"
    end
  end
end
