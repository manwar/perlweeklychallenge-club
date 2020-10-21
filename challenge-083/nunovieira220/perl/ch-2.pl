#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my @A = (3, 10, 8);

# Flip Array
my @sums = (0);

for my $val (@A) {
  my @arr = ();

  push @arr, ($_ + $val, $_ - $val) for (@sums);

  @sums = @arr;
}

my @res = grep { $_ >= 0 } sort { $a <=> $b } @sums;

# Output
say $res[0];