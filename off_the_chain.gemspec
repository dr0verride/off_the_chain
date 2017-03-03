# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'off_the_chain/version'

Gem::Specification.new do |spec|
  spec.name          = "off_the_chain"
  spec.version       = OffTheChain::VERSION
  spec.authors       = ["Justin Scott"]
  spec.email         = ["jscott7561@gmail.com"]

  spec.summary       = %q{Utility library for encapuliation a call chain.}
  spec.description   = %q{Utility library for encapuliation a call chain.}
  spec.homepage      = "https://github.com/dr0verride/off_the_chain"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
