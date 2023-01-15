#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
  [ [1,2,3,1,1,3],4 ],
  [ [1,2,3],      0 ],
  [ [1,1,1,1],    6 ],
);

is( good_pairs(@{$_->[0]}), $_->[1] ) foreach @TESTS;

sub good_pairs {
  my($c,%f);
  $f{$_}++ for @_;
  $c+=$_*($_-1) for values %f;
  $c/2;
}
done_testing();
