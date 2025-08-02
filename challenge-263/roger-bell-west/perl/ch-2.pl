#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(mergeitems([[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]]), [[1, 4], [2, 3], [3, 2]], 'example 1');
is_deeply(mergeitems([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]]), [[1, 8], [2, 3], [3, 3]], 'example 2');
is_deeply(mergeitems([[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]]), [[1, 1], [2, 9], [3, 3]], 'example 3');

sub mergeitems($aa, $bb) {
  my %c;
  foreach my $v ($aa, $bb) {
    foreach my $w (@{$v}) {
      $c{$w->[0]} += $w->[1];
    }
  }
  return [map {[$_, $c{$_}]} sort {$a <=> $b} keys %c];
}
