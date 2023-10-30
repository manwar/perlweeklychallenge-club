#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(maximisegreatness([1, 3, 5, 2, 1, 3, 1]), 4, 'example 1');
is(maximisegreatness([1, 2, 3, 4]), 3, 'example 2');

sub maximisegreatness($a) {
  my @b = sort {$::a <=> $::b} @{$a};
  my $g = 0;
  foreach my $c (@b) {
    if ($c > $b[$g]) {
      $g++;
    }
  }
  return $g;
}
