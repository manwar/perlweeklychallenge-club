#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is_deeply(smallerthancurrent([5, 2, 1, 6]), [2, 1, 0, 3], 'example 1');
is_deeply(smallerthancurrent([1, 2, 0, 3]), [1, 2, 0, 3], 'example 2');
is_deeply(smallerthancurrent([0, 1]), [0, 1], 'example 3');
is_deeply(smallerthancurrent([9, 4, 9, 2]), [2, 1, 2, 0], 'example 4');

sub smallerthancurrent($a) {
  my %l;
  my @s = sort {$::a <=> $::b} @{$a};
  foreach my $i (0..$#s) {
    my $n = $s[$i];
    unless (exists $l{$n}) {
      $l{$n} = $i;
    }
  }
  return [map {$l{$_}} @{$a}];
}
