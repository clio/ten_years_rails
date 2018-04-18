
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ten_years_rails_conf_2018/version"

Gem::Specification.new do |spec|
  spec.name          = "ten_years_rails_conf_2018"
  spec.version       = TenYearsRailsConf2018::VERSION
  spec.authors       = ["Jordan Raine"]
  spec.email         = ["jnraine@gmail.com"]

  spec.summary       = %q{Companion code to Ten Years of Rails Upgrade at RailsConf2018}
  spec.homepage      = "https://github.com/clio/ten_years_rails_conf_2018"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
