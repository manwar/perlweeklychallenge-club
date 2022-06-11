#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(tsp([[1],[5,3],[2,3,4],[7,1,0,2],[6,4,5,2,8]]),8,'example 1');

is(tsp([[5],[2,3],[4,1,4],[0,1,2,3],[7,2,4,1,9]]),9,'example 2');

use List::Util qw(min);

sub tsp {
  my $tree = shift;
  my $mp=0;
  foreach my $r (@{$tree}) {
    $mp+=min(@{$r});
  }
  return $mp;
}
