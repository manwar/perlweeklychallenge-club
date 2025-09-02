#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(smallerthancurrent([6, 5, 4, 8]), [2, 1, 0, 3], 'example 1');
is_deeply(smallerthancurrent([7, 7, 7, 7]), [0, 0, 0, 0], 'example 2');
is_deeply(smallerthancurrent([5, 4, 3, 2, 1]), [4, 3, 2, 1, 0], 'example 3');
is_deeply(smallerthancurrent([-1, 0, 3, -2, 1]), [1, 2, 4, 0, 3], 'example 4');
is_deeply(smallerthancurrent([0, 1, 1, 2, 0]), [0, 2, 2, 4, 0], 'example 5');

sub smallerthancurrent($a) {
  my @b = sort {$::a <=> $::b} @{$a};
  my %m;
  while (my ($i, $v) = each @b) {
    unless (exists $m{$v}) {
      $m{$v} = $i;
    }
  }
  return [map {$m{$_}} @{$a}];
}
