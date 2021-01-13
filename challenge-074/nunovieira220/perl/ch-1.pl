#!/usr/bin/perl

use strict;
use warnings;
use POSIX;

# Get majority element
sub get_majority {
  my %freq = ();
  $freq{$_}++ for @_;
  my $higher = (sort { $freq{$b} <=> $freq{$a} } keys(%freq))[0];
  $higher = -1 if($freq{$higher} <= @_ / 2);
  return $higher;
}

# Input/Output
if(scalar @ARGV > 0) {
  print get_majority(@ARGV)."\n";
} else {
  print get_majority((1, 2, 2, 3, 2, 4, 2))."\n";
}