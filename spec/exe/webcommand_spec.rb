require 'open3'

RSpec.describe 'webcommand cli' do
  let(:command_path) { Webcommand.root_path.join('exe/webcommand') }
  let(:base_command) { "#{command_path}" }

  describe 'server' do
    subject(:run_server) { Open3.capture3("timeout 3 #{base_command} server #{options}") }

    let(:options) { '' }

    it 'starts the server' do
      _, stderr, _  = run_server
      expect(stderr).to match(/WEBrick::HTTPServer#start: pid=\d+ port=9292/)
    end

    # TODO: Add more Scenarios and Contexts
  end
end
