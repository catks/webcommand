require 'sinatra/base'
require 'mustache'
require 'json'
require 'rack/contrib'
require 'yaml'
require 'tty-command'

require_relative 'webcommand/version'
require_relative 'webcommand/extensions/hash_extension'
require_relative 'webcommand/command'
require_relative 'webcommand/server'
require_relative 'webcommand/config'
require_relative 'webcommand/commands'

module Webcommand
  def self.config
    @config ||= Config.new(load_configuration)
  end

  def self.commands
    @commands ||= Commands.new(config[:commands])
  end

  def self.root_path
    Pathname.new File.expand_path(File.dirname(__FILE__) + '/..')
  end

  def self.load_configuration
    # TODO: Validate Configuration
    config_path = ENV['WEBCOMMAND_CONFIGURATION']
    YAML.load_file(config_path)
  end

  private_class_method :load_configuration
end
