#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(mergestrings('abcd', 1234), 'a1b2c3d4', 'example 1');
is(mergestrings('abc', 12345), 'a1b2c345', 'example 2');
is(mergestrings('abcde', 123), 'a1b2c3de', 'example 3');

use List::Util qw(max);

sub mergestrings($a, $b) {
  my @aa = split '', $a;
  my @bb = split '', $b;
  my $out;
  foreach my $i (0 .. max($#aa, $#bb)) {
    if ($i <= $#aa) {
      $out .= $aa[$i];
    }
    if ($i <= $#bb) {
      $out .= $bb[$i];
    }
  }
  return $out;
}
