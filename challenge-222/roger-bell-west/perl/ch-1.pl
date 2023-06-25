#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(matchingmembers([1, 1, 4, 2, 1, 3]), 3, 'example 1');
is(matchingmembers([5, 1, 2, 3, 4]), 0, 'example 2');
is(matchingmembers([1, 2, 3, 4, 5]), 5, 'example 3');

sub matchingmembers($a) {
  my @b=sort @{$a};
  my $o = 0;
  foreach my $i (0 .. $#b) {
    if ($a->[$i] == $b[$i]) {
      $o++;
    }
  }
  return $o;
}
