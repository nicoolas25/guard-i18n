# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard/i18n/version"

Gem::Specification.new do |s|
  s.name        = "guard-i18n"
  s.version     = Guard::I18n::VERSION
  s.authors     = ["Nicolas ZERMATI"]
  s.email       = ["nicoolas25@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Automatically generate js files from locales files.}
  s.description = %q{Automatically generate js files from locales files.}

  # s.rubyforge_project = "guard-i18n"

  s.files = Dir.glob('{lib}/**/*') #+ %w[README.md]
  s.require_path =  ['lib']

  # specify any dependencies here; for example:
  s.add_dependency "guard"
end
