RSpec.describe Webcommand::Server do
  using RSpec::Parameterized::TableSyntax

  let(:app) { described_class.new }

  before do
    ENV['WEBCOMMAND_CONFIGURATION'] = Webcommand.root_path.join('spec/fixtures/config.yml').to_s
  end

  describe '#POST executions' do
    subject(:executions) { post('/executions', payload.to_json, { 'CONTENT_TYPE' => 'application/json' }) }

    let(:response) { executions }
    let(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }

    context 'com um comando cadastrado' do
      context 'com parâmetros válidos' do
        where(:payload, :stdout, :stderr, :exit_status) do
          [
            [{ command: 'hello_world', params: { world: 'opa'} }, "Hello opa\n", '', 0],
            [{ command: 'hello_two_worlds', params: { world1: 'mundo1', world2: 'mundo2'} }, "Hello mundo1 & mundo2\n", '', 0],
            [{ command: 'hello_validation', params: { world_string: 'Show'} }, "Hello Show\n", '', 0],
            [{ command: 'my_error', params: { exit_status: 123 } }, '', '', 123]
          ]
        end

        with_them do
          it 'retorna o status 200' do
            expect(response.status).to eq(200)
          end

          it 'retorna o output do comando executado' do
            expect(parsed_response[:stdout]).to eq(stdout)
          end

          it 'retorna o exit_status' do
            expect(parsed_response[:exit_status]).to eq(exit_status)
          end

          it 'retorna o output do comando executado' do
            expect(parsed_response[:stderr]).to eq('')
          end
        end
      end

      context 'com parâmetros inválidos' do
        where(:payload, :error) do
          [
            [{ command: 'hello_world', params: { wrong_parameter: 'opa'} }, "InvalidParams"],
            [{ command: 'hello_world' }, "InvalidParams"],
            [{ command: 'hello_two_worlds', params: { world2: 'mundo2'} }, "WrongParamsSize"],
            [{ command: 'hello_validation', params: { world_string: '123'} }, "InvalidParams"]
          ]
        end

        with_them do
          it 'retorna o status 422' do
            expect(response.status).to eq(422)
          end

          it 'retorna o erro' do
            expect(parsed_response[:error]).to eq(error)
          end
        end
      end

      context 'com um comando inválido' do
        let(:payload) do
          {
            command: 'no_ecziste'
          }
        end

        it 'retorna o status 422' do
          expect(response.status).to eq(422)
        end

        it 'retorna o erro' do
          expect(parsed_response[:error]).to eq('CommandNotRegistered')
        end
      end
    end
  end
end
