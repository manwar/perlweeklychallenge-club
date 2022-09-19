#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @rev_nums;

is_reversible($_) and push @rev_nums, $_ for 1 .. 100;

say join ', ', @rev_nums;

sub is_reversible {
  my $sum = $_[0] + reverse $_[0];
  for (split //, $sum) {
    return if is_even($_);
  }

  return 1;
}

sub is_even {
  return if ($_[0] % 2);
  return 1;
}
