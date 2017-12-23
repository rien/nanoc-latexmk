require File.expand_path('../lib/nanoc/latexmk/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'nanoc-latexmk'
  s.version       = Nanoc::Latexmk::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Rien Maertens']
  s.email         = ['maertensrien@gmail.com']
  s.homepage      = 'https://github.com/rien/nanoc-latexmk'
  s.summary       = 'Latexmk filter for nanoc.'
  s.description   = 'Nanoc filter to convert latex files to pdf using latexmk'
  s.files         = `git ls-files`.split('\n')
  s.executables   = `git ls-files`.split('\n').map { |f| f =~ %r{^bin\/(.*)} ? $1 : nil }.compact
  s.require_path  = 'lib'
end
