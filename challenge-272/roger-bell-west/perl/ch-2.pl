#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(stringscore('hello'), 13, 'example 1');
is(stringscore('perl'), 30, 'example 2');
is(stringscore('raku'), 37, 'example 3');

sub stringscore($a) {
  my $out = 0;
  my @c = split '',$a;
  foreach my $i (0 .. $#c - 1) {
    $out += abs(ord($c[$i]) - ord($c[$i+1]));
  }
  return $out;
}
