#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw[min max];

# Input
my $A = "abcdabcd";
my $B = "abcdabcdabcdabcd";

# Common Base String
my @res = ();
my $len = min(length($A), length($B));

for (my $i = 0; $i < $len; $i++) {
  my $base = substr($A, 0, $i+1);

  push(@res, $base) if($A =~ /^($base)+$/ && $B =~ /^($base)+$/);
}

# Output
print join(', ', @res);