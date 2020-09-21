#!/usr/bin/perl

use strict;
use warnings;

# Input
my @A = (7, 4, 2, 6, 3);
my @B = (1, 3, 4);

# Execute left rotation
my @arr = ();
my $index = 0;

for my $i (@B) {
  my $jump = $i - $index;

  for(my $j = 0; $j < $jump; $j++) {
    my $val = shift @A;
    push @A, $val;
  }

  $index += $jump;

  # Output
  my $res = join ", ", @A;
  print $res."\n";
}