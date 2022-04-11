#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [1,3,5,7,9],  3 ],
  [ [1,2,3,4,5], -1 ],
  [ [2,4,2],      1 ],
  [ [1,-1,1],     0 ], ## Not sure if -ve values allowed?

);

is( equilibrium_index(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub equilibrium_index {
  my $s = 0;
  $s += $_ for @_;
  ($s==$_[$_]) ? (return $_) : ($s-=2*$_[$_]) for 0..$#_;
  -1;
}

