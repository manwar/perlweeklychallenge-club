#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(similarwords(['aba', 'aabb', 'abcd', 'bac', 'aabc']), 2, 'example 1');
is(similarwords(['aabb', 'ab', 'ba']), 3, 'example 2');
is(similarwords(['nba', 'cba', 'dba']), 0, 'example 3');

sub similarwords($a) {
  my %ct;
  my $ac = ord('a');
  foreach my $w (@{$a}) {
    my %hs = map {$_ => 1} split '', $w;
    my $mask = 0;
    foreach my $c (keys %hs) {
      $mask |= 1 << (ord($c) - $ac);
    }
    $ct{$mask}++;
  }
  my $pairs = 0;
  foreach my $cv (values %ct) {
    if ($cv > 1) {
      $pairs += $cv * ($cv - 1) / 2;
    }
  }
  return $pairs;
}
