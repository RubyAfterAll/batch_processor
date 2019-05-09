
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "batch_processor/version"

Gem::Specification.new do |spec|
  spec.name          = "batch_processor"
  spec.version       = BatchProcessor::VERSION
  spec.authors       = ["Eric Garside"]
  spec.email         = ["garside@gmail.com"]

  spec.summary       = "Write extensible batches for sequential or parallel processing using ActiveJob"
  spec.description   = "Define your collection, job, and callbacks all in one clear and concise object"
  spec.homepage      = "http://www.freshly.com"
  spec.license       = "MIT"

  spec.add_runtime_dependency "activejob", "~> 5.2.1"
  spec.add_runtime_dependency "activesupport", "~> 5.2.1"
  spec.add_runtime_dependency "spicerack", "~> 0.7.4"

  spec.add_development_dependency "bundler", "~> 2.0.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "rubocop", "~> 0.68.1"
  spec.add_development_dependency "rubocop-rspec", "~> 1.32.0"
  spec.add_development_dependency "faker", "~> 1.8"
  spec.add_development_dependency "pry-byebug", ">= 3.7.0"

  spec.add_development_dependency "rspice", "~> 0.7.1"
  spec.add_development_dependency "spicerack-styleguide", "~> 0.7.4"
  spec.add_development_dependency "shoulda-matchers", "4.0.1"
end
