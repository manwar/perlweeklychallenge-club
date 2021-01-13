#!/usr/bin/perl

use strict;
use warnings;

# Input
my @list = scalar @ARGV ? @ARGV : (3, 1, 3, 1, 1, 5);

# Trapped rain water counter
my $counter = 0;
my $max = 0;

for my $item (@list) {
  if($item >= $max) {
    $max = $item;
  } else {
    $counter += $max - $item;
  }
}

# Output
print $counter."\n";