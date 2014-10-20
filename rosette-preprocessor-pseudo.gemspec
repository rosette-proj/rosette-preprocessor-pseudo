$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rosette/preprocessors/pseudo-preprocessor/version'

Gem::Specification.new do |s|
  s.name     = "rosette-preprocessor-pseudo"
  s.version  = ::Rosette::Preprocessors::PSEUDO_PREPROCESSOR_VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["camertron@gmail.com"]
  s.homepage = "http://github.com/camertron"

  s.description = s.summary = "Pseudo-English translator for the Rosette internationalization platform."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "README.md", "Rakefile", "rosette-preprocessor-pseudo.gemspec"]
end
