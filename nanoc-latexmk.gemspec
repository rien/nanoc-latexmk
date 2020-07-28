require File.expand_path('../lib/nanoc/latexmk/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'nanoc-latexmk'
  s.version       = Nanoc::Latexmk::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Rien Maertens']
  s.email         = ['rien.maertens@posteo.be']
  s.homepage      = 'https://github.com/rien/nanoc-latexmk'
  s.summary       = 'Latexmk filter for nanoc.'
  s.description   = 'Nanoc filter to convert latex files to pdf using latexmk'
  s.license       = 'Unlicense'
  s.files         = `git ls-files`.split("\n")
  s.require_path  = 'lib'
end
