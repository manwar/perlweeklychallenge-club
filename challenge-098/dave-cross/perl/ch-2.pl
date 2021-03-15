#!/usr/bin/perl

use strict;
use warnings;
use feature qw[say signatures];
no warnings 'experimental::signatures';

use Test::More;

my @tests = ({
  array => [1, 2, 3, 4],
  n     => 3,
  exp   => 2,
}, {
  array => [1, 3, 5, 7],
  n     => 6,
  exp   => 3,
}, {
  array => [12, 14, 16, 18],
  n     => 10,
  exp   => 0,
}, {
  array => [11, 13, 15, 17],
  n     => 19,
  exp   => 4,
});

for (@tests) {
  is get_index($_->{array}, $_->{n}), $_->{exp};
}

done_testing;

sub get_index {
  my ($arr, $n) = @_;

  for (0 .. $#$arr) {
    return $_ if $arr->[$_] >= $n;
  }

  return scalar @$arr;
}
