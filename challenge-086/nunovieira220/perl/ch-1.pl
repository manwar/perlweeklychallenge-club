#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my @N = (10, 8, 12, 15, 5);
my $A = 7;

# Pair Difference
my $res = 0;
my $len = scalar @N;

for(my $i = 0; $i < $len - 1; $i++) {
  for($i..$len - 1) {
    if($N[$i] - $N[$_] == $A || $N[$_] - $N[$i] == $A) {
      $res = 1;
      last;
    }
  }

  last if($res == 1);
}

# Output
say $res;