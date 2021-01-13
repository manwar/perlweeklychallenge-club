#! /usr/bin/env ruby

begin
  puts Gem::Version.new(ARGV[0]) <=> Gem::Version.new(ARGV[1]);
rescue
  puts "ERROR";
end

  
