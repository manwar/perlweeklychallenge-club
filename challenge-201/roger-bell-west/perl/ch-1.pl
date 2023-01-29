#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(missingnumber([0, 1, 3]), 2, 'example 1');
is(missingnumber([0, 1]), 2, 'example 2');

sub missingnumber($l) {
  my %v = map {$_ => 1} @{$l};
  foreach my $i (0..scalar @{$l}) {
    if (!exists $v{$i}) {
      return $i;
    }
  }
  return 0;
}
