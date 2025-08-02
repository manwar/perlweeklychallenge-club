#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(strongpair([1, 2, 3, 4, 5]), 4, 'example 1');
is(strongpair([5, 7, 1, 7]), 1, 'example 2');

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(min);

sub strongpair($a0) {
  my @a = sort {$a <=> $b} keys %{{map {$_ => 1} @{$a0}}};
  my $count = 0;
  my $ip = combinations(\@a, 2);
  while (my $c = $ip->next) {
    if (abs($c->[0] - $c->[1]) < min(@{$c})) {
      $count++;
    }
  }
  return $count;
}
