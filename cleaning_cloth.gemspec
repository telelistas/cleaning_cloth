$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cleaning_cloth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cleaning_cloth"
  s.version     = CleaningCloth::VERSION
  s.authors     = ["nardele salomon"]
  s.email       = ["del.soft.99@gmail.com"]
  s.homepage    = "https://github.com/telelistas/cleaning-cloth"
  s.summary     = "An Rails/Active Record extension. You will clean all atributes of active record"
  s.description = "An Rails/Active Record extension. You will clean all atributes of active record"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "activesupport", "~> 4.1.6"
  s.add_dependency "activerecord", "~> 4.1.6"
  s.add_dependency "ds_hash"
  # s.add_dependency "rspec-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
