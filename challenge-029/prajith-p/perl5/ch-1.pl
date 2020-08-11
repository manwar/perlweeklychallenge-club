#!/usr/bin/perl

use feature qw<say>;

my $arg = $ARGV[0];

if ($arg =~ m/\{(.+)\}/) { 
  for my $str  (split(',', $1)) {
      (my $o = $arg ) =~ s/(\{.+\})/$str/;
      say $o;
  }
} 
