#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(largestofthree([8, 1, 9]), 981, 'example 1');
is(largestofthree([8, 6, 7, 1, 0]), 8760, 'example 2');

use Algorithm::Combinatorics qw(combinations);

sub largestofthree($digits) {
  my @ordered = sort {$b <=> $a} @{$digits};
  my $mx = 0;
  foreach my $n (reverse(0 .. $#ordered)) {
    foreach my $c (combinations(\@ordered, $n + 1)) {
      my $t = 0;
      foreach my $d (@{$c}) {
        $t *= 10;
        $t += $d;
      }
      if ($t > $mx && $t % 3 == 0) {
        $mx = $t;
      }
    }
  }
  return $mx;
}
