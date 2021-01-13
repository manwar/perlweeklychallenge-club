#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use POSIX;

# Input
my $A = 14;
my $B = 12;

# Ethiopian Multiplication
my $res = 0;

while($A > 1) {
  $A = floor($A / 2);
  $B = $B * 2;
  $res += $B;
}

# Output
say $res;