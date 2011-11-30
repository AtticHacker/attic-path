# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name = 'attic-path'
  spec.version ='0.0.2'
  spec.platform    = Gem::Platform::RUBY

  spec.files = ["README.md", "lib/attic-path.rb", "lib/attic-path/attic_path_commands.rb", "lib/attic-path/attic_path_input.rb"]
  spec.require_paths = ["lib"]

  spec.summary = "Attic Path is a gem that gives you more options for gets.chomp. With Attic Path you can browse your system while being in the gets.chomp. The user can select files and add them into an array."
  spec.author = 'Kevin van Rooijen'
  spec.email = 'attichacker@gmail.com'
  spec.homepage = 'http://rubygems.org/gems/attic-path'


  spec.add_dependency 'fileutils'
  spec.add_dependency 'terminal-table'
end