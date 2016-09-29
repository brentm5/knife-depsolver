$:.unshift(File.dirname(__FILE__) + '/lib')
require 'knife-depsolver/version'

Gem::Specification.new do |s|
  s.name = 'knife-depsolver'
  s.version = KnifeDepsolver::VERSION
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = ["README.md", "LICENSE", "CHANGELOG.md" ]
  s.summary = "Knife plugin that uses Chef Server to calculate cookbook dependencies for a given run_list."
  s.description = s.summary
  s.authors = [ "Jeremiah Snapp" ]
  s.email = "support@chef.io"
  s.homepage = "https://github.com/jeremiahsnapp/knife-depsolver"
  s.require_path = 'lib'
  s.files = %w(LICENSE README.md) + Dir.glob("lib/**/*")

  s.add_dependency 'chef', '~> 12.11'
end
