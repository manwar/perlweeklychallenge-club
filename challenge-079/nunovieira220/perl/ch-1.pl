#!/usr/bin/perl

use strict;
use warnings;

# Input
my $N = $ARGV[0] || 7;

# Count set bits
my $counter = 0;

for ((1..$N)) {
  my $bin = sprintf ("%b", $_);
  $counter += () = $bin =~ /1/g;
}

# Output
my $res = $counter % 1000000007;
print $res."\n";