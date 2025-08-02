#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(arraysintersection([[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]]), [1, 4], 'example 1');
is_deeply(arraysintersection([[1, 0, 2, 3], [2, 4, 5]]), [2], 'example 2');
is_deeply(arraysintersection([[1, 2, 3], [4, 5], [6]]), [], 'example 3');

sub arraysintersection($a) {
  my %s = map {$_ => 1} @{$a->[0]};
  foreach my $bi (1 .. $#{$a}) {
    %s = map {$_ => 1} grep {exists $s{$_}} @{$a->[$bi]};
  }
  [sort {$::a <=> $::b} keys %s];
}
