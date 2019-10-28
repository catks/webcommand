module Webcommand
  class CLI < Thor
    desc "server", "Start the Webcommand server"
    option :port, default: 9292
    option :threads, default: 8
    option :workers, default: 1
    def server
      exec "bundle exec puma " \
       "-p #{options[:port]} " \
       "-t #{options[:threads]}:#{options[:threads]} " \
       "-w #{options[:workers]} " \
       "#{Webcommand.root_path.join('config.ru')}"
    end
  end
end
