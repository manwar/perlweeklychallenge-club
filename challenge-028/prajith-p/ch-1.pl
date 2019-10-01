#!/usr/bin/perl

my $file = $ARGV[0];

my $r = -r $file  ? (
        -B $file  ? 
          "The file content is binary" 
        : "The file content is ascii" ) 
        : "Could not open file: $file";
print $r;
