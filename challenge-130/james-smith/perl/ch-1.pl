#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [2, 5, 4, 4, 5, 5, 2], 5 ],
  [ [1, 2, 3, 4, 3, 2, 1, 4, 4], 4 ],
);

is( find_odd($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub find_odd {
  my %x;
  $x{$_}++ foreach @{$_[0]};
  return ( grep { $x{$_}&1 } keys %x )[0];
}

