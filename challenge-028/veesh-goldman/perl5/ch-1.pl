#! /usr/bin/env perl

use v5.22;

#activate slurp mode
local $/;
while (<>) {
  #print the name of the file we're checking
  print "$ARGV - ";
  say 'The file content is binary' and next if /[[^:ascii:]]/;
  say 'The file content is ascii'
}


