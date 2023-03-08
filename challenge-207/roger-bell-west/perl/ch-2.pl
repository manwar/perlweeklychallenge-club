#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(h_index([10, 8, 5, 4, 3]), 4, 'example 1');
is(h_index([25, 8, 5, 3, 3]), 3, 'example 2');

sub h_index($c0) {
  my @c = sort {$b <=> $a} @{$c0};
  my $h = 0;
  foreach my $i (0..$#c) {
    if ($i + 1 <= $c[$i]) {
      $h = $i + 1;
    } else {
      last;
    }
  }
  return $h;
}
