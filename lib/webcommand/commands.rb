module Webcommand
  class Commands
    CommandNotRegistered = Class.new(StandardError)

    def initialize(commands_config)
      @commands = commands_config.map do |key, command_config|
        params_schema = command_config[:params]&.map { |key, value| [key, Regexp.new(value)] }.to_h

        [key, Command.new(command_config[:command], params_schema: params_schema)]
      end.to_h

      @commands.default_proc = ->(_,key) { raise CommandNotRegistered, "Command #{key} not found" }
    end

    def [](command_key)
      @commands[command_key]
    end
  end
end
