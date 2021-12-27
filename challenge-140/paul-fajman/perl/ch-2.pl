#!/usr/bin/perl

# Weekly Challenge 140 Task 2
#
# You are given 3 positive integers, $i, $j and $k.
#
# Write a script to print the $kth element in the sorted multiplication table of $i and $j.

use strict;
use warnings;

my ($i, $j, $k);

if ($#ARGV eq 2) {
  $i = $ARGV[0];
  $j = $ARGV[1];
  $k = $ARGV[2];
}
else {
  print "Using test data. Provide 3 input numbers to test your own numbers.\n";
  $i = 3;
  $j = 3;
  $k = 6;
}

my @mtable;

for my $x (1..$i) {
  for my $y (1..$j) {
    push @mtable, $x*$y;
  }
}

# Need the $a <=> $b comparison for numeric values
my @stable = sort { $a <=> $b } @mtable;
my $kth = $stable[$k-1];

print "\n$kth is element number $k in multiplication table $i x $j\n";
