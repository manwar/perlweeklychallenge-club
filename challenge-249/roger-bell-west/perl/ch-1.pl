#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(shortestdistance([3, 2, 3, 2, 2, 2]), [[2, 2], [2, 2], [3, 3]], 'example 1');
is_deeply(shortestdistance([1, 2, 3, 4]), [], 'example 2');

sub shortestdistance($a0) {
  if (scalar @{$a0} % 2 != 0) {
    return [];
  }
  my @a = sort {$a <=> $b} @{$a0};
  my @out;
  for (my $i = 0; $i < scalar @a; $i+=2) {
    if ($a[$i] != $a[$i+1]) {
      return [];
    }
    push @out,[$a[$i], $a[$i]];
  }
  return \@out;
}
