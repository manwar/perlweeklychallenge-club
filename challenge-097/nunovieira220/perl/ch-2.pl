#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my $B = "10110111";
my $S = 4;

# Binary Substrings
my @chunk = unpack("(A$S)*", $B);
my $min = 0;

foreach my $a (@chunk) {
  my $max = 0;

  foreach my $p (@chunk) {
    my $newMax = 0;
    my $mask = $a ^ $p;
    $newMax++ while($mask =~ /[^\0]/g);
    $max = $newMax if($newMax > $max);
  }

  $min = $max if($max > $min);
}

# Output
say($min);
