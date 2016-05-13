# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'courier/version'

Gem::Specification.new do |spec|
  spec.name          = "courier"
  spec.version       = Courier::VERSION
  spec.authors       = ["Raecoo Cao"]
  spec.email         = ["raecoo@gmail.com"]

  spec.summary       = "Threadsafe, Faraday Based"
  spec.description   = "Courier is a lightweight gem for accessing the Shopify admin REST web services."
  spec.homepage      = "https://github.com/raecoo/courier"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency("faraday", "~> 0.9.1")
  spec.add_dependency("faraday_middleware", ">= 0")
  spec.add_dependency("recursive-open-struct", "~> 1.0.1")
end
