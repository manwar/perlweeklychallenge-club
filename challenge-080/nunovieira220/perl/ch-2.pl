#!/usr/bin/perl

use strict;
use warnings;

# Input
my @A = @ARGV || (1, 4, 3, 2);

#  Count candies
my $len = scalar @A;
my $counter = $len;

push @A, ~0;

for (my $i = $len - 1; $i >= 0; $i--) {
  $counter += ($A[$i] > $A[$i-1]) + ($A[$i] > $A[$i+1]);
}

# Output
print $counter."\n";