require 'coveralls'
Coveralls.wear!

require 'rspec/core'
require 'nanoc/latexmk'
require 'nanoc'

unless defined?(SPEC_ROOT)
  SPEC_ROOT = File.expand_path('../', __FILE__)
end
