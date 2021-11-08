#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1,2,3,4,5],[4,6,7,8,9],0 ],
  [ [1,3,5,7,9],[0,2,4,6,8],1 ],
);

is( disjoint_sets($_->[0],$_->[1]), $_->[2] ) foreach @TESTS;

done_testing();

sub disjoint_sets {
  my %m = map { $_=>1 } @{$_[0]};
  return grep( { $m{$_} } @{$_[1]}) ? 0 : 1;
}

