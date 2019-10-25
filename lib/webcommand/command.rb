module Webcommand
  class Command
    DEFAULT_PARAM_SCHEMA_REGEX = /.*/
    PARAMS_DEFAULT_SCHEMA = {}.tap do |hash|
      hash.default_proc = proc { DEFAULT_PARAM_SCHEMA_REGEX }
    end

    WrongParamsSize = Class.new(StandardError)
    InvalidParams = Class.new(StandardError)

    def initialize(template_command, params_schema: nil, executor: TTY::Command)
      @template_command = template_command
      @params_schema = params_schema || PARAMS_DEFAULT_SCHEMA
      @executor = executor
    end

    def call(**params)
      raise WrongParamsSize, params if wrong_params_size?(params)
      raise InvalidParams, params unless valid_params?(params)

      template_render = make_template_renderer(params)
      command = template_render.render(@template_command)
      #TODO: Extract executor to a new class returning a customized execution result
      @executor.new.run!(command)
    end

    private

    def wrong_params_size?(params)
      @params_schema.keys.size != 0 && params.keys.size != @params_schema.keys.size
    end

    def valid_params?(params)
      return false unless params.keys == template_command_keys
      return true if @params_schema == PARAMS_DEFAULT_SCHEMA

      params.keys.reduce(true) do |result, key|
        result && @params_schema[key].match?(params[key])
      end
    end

    def template_command_keys
      @template_command.scan(/{{(.*?)}}/).flatten.map(&:to_sym)
    end

    def make_template_renderer(params)
      Mustache.new.tap do |template|
        params.each do |key, value|
          template[key] = value
        end
      end
    end
  end
end
