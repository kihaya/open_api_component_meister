require_relative 'lib/open_api_component_meister/version'

Gem::Specification.new do |spec|
  spec.name          = "open_api_component_meister"
  spec.version       = OpenApiComponentMeister::VERSION
  spec.authors       = ["Kihaya Sugiura"]
  spec.email         = ["kihayas@gmail.com"]

  url = "https://github.com/kihaya/open_api_component_meister"
  spec.summary       = %q{Generate and check Open API Component from ActiveRecord model.}
  spec.description   = %q{Generate and check Open API Component from ActiveRecord model.}
  spec.homepage      = url
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = url
  spec.metadata["changelog_uri"] = url

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "> 5.2"

  spec.add_development_dependency "sqlite3", "~> 1.0"
end
