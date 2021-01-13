#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw[min];
use Math::Prime::Util qw[is_prime];

# Calculate prime num
sub prime_sum {
  my $N = $_[0];
  my %calcs = ();
  $calcs{2} = 1;

  for(my $i = 3; $i <= $N; $i += 2) {
    if(is_prime($i)) {
      for my $key (keys %calcs) {
        my $sum = $i + $key;
        my $inc = $calcs{$key} + 1;
        $calcs{$sum} = $calcs{$sum} ? min($calcs{$sum}, $inc) : $inc;
      }

      $calcs{$i} = 1;
    }
  }

  return $calcs{$N} || 0;
}

# Input/Output
my $N = scalar @ARGV ? $ARGV[0] : 9;
print prime_sum($N)."\n";