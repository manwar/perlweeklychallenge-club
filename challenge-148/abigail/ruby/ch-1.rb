#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#
 
#
# Run as: ruby ch-1.rb
#

puts ((0 .. 100) . reject {|n| n . to_s =~ /^0$|[1789]|^2.|[35]$/} . join (" "))
