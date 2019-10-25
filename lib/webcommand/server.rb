module Webcommand
  class Server < Sinatra::Application
    use Rack::PostBodyContentTypeParser
    before do
      content_type 'application/json'
    end

    using Webcommand::Extensions::HashExtension

    post '/executions' do
      command_name = params[:command].to_sym
      command_params = params[:params]&.symbolize_keys || {}
      command = Webcommand.commands[command_name]
      execution = command.call(**command_params)

      # TODO: Create a Serializer after creating a new Execution Result object
      { stdout: execution.out.to_s, stderr: execution.err.to_s, exit_status: execution.status }.to_json
    rescue Command::WrongParamsSize, Command::InvalidParams, Commands::CommandNotRegistered => ex
      halt 422, { error: ex.class.name.split('::').last }.to_json
    end
  end
end
