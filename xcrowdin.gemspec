# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "xcrowdin/version"

Gem::Specification.new do |spec|
  spec.name          = "xcrowdin"
  spec.version       = Xcrowdin::VERSION
  spec.authors       = ["yoonchul.koh"]
  spec.email         = ["yoonchul.koh@gmail.com"]

  spec.summary       = "Xcode to Crowdin exporter and Cronwdin to Xcode Importer."
  spec.homepage      = "https://github.com/yoonchulkoh/xcrowdin"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "crowdin-api"
  spec.add_development_dependency "rubyzip"
  spec.add_development_dependency "thor"
end
