# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'globalsms/version'

Gem::Specification.new do |spec|
  spec.name          = "globalsms"
  spec.version       = GlobalSMS::VERSION
  spec.authors       = ["Salih Özdemir"]
  spec.email         = ["me@salihozdemir.net"]

  spec.summary       = %q{GlobalHaberlesme.com API leri İçin Ruby Gem}
  spec.description   = %q{GlobalHaberlesme API leri aracılığıyla SMS gönderme, rapor alma ve benzeri işlerin yapılabileceği Ruby Gem idir.}
  spec.homepage      = "https://github.com/salihozd/globalsms/"
  spec.license       = "MIT"

  spec.required_ruby_version = '~> 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency 'httpclient', '~> 0'
end
