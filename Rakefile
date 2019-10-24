require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :environment do
  require_relative 'lib/webcommand'
end

task server: :environment do
  Webcommand::Server.start!
end

task :console do
  exec 'pry -r ./lib/webcommand.rb'
end
