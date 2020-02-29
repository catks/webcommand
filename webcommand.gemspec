lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "webcommand/version"

Gem::Specification.new do |spec|
  spec.name          = "webcommand"
  spec.version       = Webcommand::VERSION
  spec.authors       = ["Carlos Atkinson Ferreira Filho"]
  spec.email         = ["carlos.atks@gmail.com"]

  spec.summary       = %q{Runs commands from a webpage}
  spec.homepage      = "https://github.com/catks/webcommand"
  spec.license       = "MIT"

  spec.metadata["source_code_uri"] = "https://github.com/catks/webcommand"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra", "~> 2.0.7"
  spec.add_dependency "thor", "~> 0.20.3"
  spec.add_dependency "mustache", "~> 1.0"
  spec.add_dependency "rack-contrib", "~> 2.1.0"
  spec.add_dependency "tty-command", "~> 0.9.0"
  spec.add_dependency "puma", ">= 4.2.1", "< 4.4.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
