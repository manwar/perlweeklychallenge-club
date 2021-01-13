#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use POSIX qw/floor/;

# Basic strategy: Use a hash to keep track of the number of occurences
# of each element, and the first one that's greater than the
# ⌊$N/2⌋ limit, display it and stop.

sub task1 {
  my @A = @_;

  my $cutoff = floor(@A / 2.0);
  my %counts;
  for my $elem (@A) {
    $counts{$elem}++;
    if ($counts{$elem} > $cutoff) {
      say $elem;
      return;
    }
  }
  say -1;
}

task1 1, 2, 2, 3, 2, 4, 2;
task1 1, 3, 1, 2, 4, 5;
