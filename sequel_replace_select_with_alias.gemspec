# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "sequel_replace_select_with_alias"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["mnussbaum"]
  s.email       = ["michaelnussbaum08@gmail.com"]
  s.homepage    = "http://github.com/mnussbaum/sequel_replace_select_with_alias"
  s.summary     = %q{Mutate sequel datasets to replace selected columns with aliases}
  s.description = %q{This gem allows you to replace a column selection in a dataset with an alias for the same column name.}

  s.rubyforge_project = "sequel_replace_select_with_alias"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "sequel", "~> 4.8.0"
  s.add_development_dependency "rspec", "~> 2.14.1"
end
