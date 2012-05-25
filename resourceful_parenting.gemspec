# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|

  # Description Meta...
  s.name        = 'resourceful_parenting'
  s.version     = 0.1
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Mina Naguib']
  s.email       = ['mina.gems@naguib.ca']
  s.homepage    = 'http://github.com/minaguib/resourceful_parenting'
  s.summary     = %q{A rails plugin that makes working with nested resources easier.}
  s.description = %q{A rails plugin that makes working with nested resources easier.}
  s.rubyforge_project = 'resourceful_parenting'


  # Load Paths...
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']


  # Dependencies (installed via 'bundle install')...
  s.add_development_dependency("bundler", [">= 1.0.0"])
  s.add_development_dependency("actionpack", [">= 3.0.0"])
  s.add_development_dependency("rdoc")
end
