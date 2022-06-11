#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my @TESTS_POS = (
  [ [1,3,5,7,9],  3 ],
  [ [1,2,3,4,5], -1 ],
  [ [2,4,2],      1 ],
  [ [1..51,1275],50 ],
);

my @TESTS = (
  @TESTS_POS,
  [ [1,-1,1],     0 ], ## Not sure if -ve values allowed?
  [ [-2,4,-2,1],  3 ],
);

is( equilibrium_index(         @{$_->[0]}), $_->[1] ) foreach @TESTS;
is( equilibrium_index_positive(@{$_->[0]}), $_->[1] ) foreach @TESTS_POS;

done_testing();

## This doesn't assume anything about sign of values;
##
## There is a possible optimization if you only allow
## positive values that you can return -1 if $s<$_[$_]
## as once you have passed the balance point you can
## stop.

sub equilibrium_index {
  my $s = 0;
  $s += $_ for @_;
  $s==$_[$_] ? (return $_) : ($s-=2*$_[$_]) for 0..$#_;
  -1;
}

## Optimized solution for +ve values only....

sub equilibrium_index_positive {
  my $s = 0;
  $s += $_ for @_;
  $s==$_[$_] ? (return $_) : $s<$_[$_] ? (return -1) : ($s-=2*$_[$_]) for 0..$#_;
  -1;
}

