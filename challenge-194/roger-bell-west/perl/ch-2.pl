#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(frequencyequalizer("abbc"), 1, 'example 1');
is(frequencyequalizer("xyzyyxz"), 1, 'example 2');
is(frequencyequalizer("xzxz"), 0, 'example 3');

sub frequencyequalizer($s) {
  my %f;
  foreach my $c (split '',$s) {
    $f{$c}++;
  }
  my @v = sort values %f;
  if ($v[0] == $v[-2] &&
      $v[0] + 1 == $v[-1]) {
    return 1;
  }
  return 0;
}
