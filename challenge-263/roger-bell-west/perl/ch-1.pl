#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(targetindex([1, 5, 3, 2, 4, 2], 2), [1, 2], 'example 1');
is_deeply(targetindex([1, 2, 4, 3, 5], 6), [], 'example 2');
is_deeply(targetindex([5, 3, 2, 4, 2, 1], 4), [4], 'example 3');

sub targetindex($a0, $k) {
  my @a = sort {$a <=> $b} @{$a0};
  return [grep { $a[$_] == $k } (0 .. $#a)];
}
