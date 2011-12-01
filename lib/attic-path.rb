#!/usr/bin/env ruby
require "fileutils"
require "terminal-table"

$:.unshift File.dirname(__FILE__)
%w(commands input).each do |file|
  require "attic-path/#{file}"
end

begin
  require 'fileutils'
  require 'terminal-table'
rescue LoadError
  puts "\n You must have fileutils and terminal-table installed in order to use attic-path."
  puts "fileutils should already be installed."
  puts "gem install terminal-table"
  puts "if this still doesn't fix this problem then you might not have fileutils"
  exit 1
end
