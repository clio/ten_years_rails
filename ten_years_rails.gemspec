
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ten_years_rails/version"

Gem::Specification.new do |spec|
  spec.name          = "ten_years_rails"
  spec.version       = TenYearsRails::VERSION
  spec.authors       = ["Jordan Raine"]
  spec.email         = ["jnraine@gmail.com"]

  spec.summary       = %q{Companion code to Ten Years of Rails Upgrades}
  spec.homepage      = "https://github.com/clio/ten_years_rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "colorize", ">= 0.8.1"
  spec.add_dependency "rest-client", ">= 2.0.2"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "timecop", "~> 0.9.1"
  spec.add_runtime_dependency "actionview"
end
