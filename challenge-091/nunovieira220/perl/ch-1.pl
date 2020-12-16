#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my $N = 2333445;

# Count Number
my $S = "$N";
my $res = "";
my $last = substr($S, 0, 1);
my $counter = 1;

foreach my $C (split //, substr($S, 1, length($S))) {
  if($C != $last) {
    $res .= $counter.$last;
    $counter = 0;
    $last = $C;
  }

  $counter++;
}

# Output
say ($res, $counter, $last);