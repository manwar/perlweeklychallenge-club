#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(countsmaller([8, 1, 2, 2, 3]), [4, 0, 1, 1, 3], 'example 1');
is_deeply(countsmaller([6, 5, 4, 8]), [2, 1, 0, 3], 'example 2');
is_deeply(countsmaller([2, 2, 2]), [0, 0, 0], 'example 3');

sub countsmaller($nums) {
  my @b = sort {$a <=> $b} @{$nums};
  my %sm;
  my $l = 0;
  foreach my $i (0 .. $#b) {
    my $e = $b[$i];
    if ($i == 0 || $e != $l) {
      $sm{$e} = $i;
      $l = $e;
    }
  }
  return [map {$sm{$_}} @{$nums}];
}
