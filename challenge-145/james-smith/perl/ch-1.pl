#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1,2,3], [4,5,6],     32 ],

  [ [1..10],  [1..10],    385 ],
  [ [1..100], [1..100],   338_350 ],
  [ [1..1e3], [1..1e3],   333_833_500 ],
  [ [1..1e4], [1..1e4],   333_383_335_000 ],
  [ [1..1e5], [1..1e5],   333_338_333_350_000 ],
  [ [1..1e6], [1..1e6],   333_333_833_333_500_000 ],

  [ [1..10], [reverse 1..10], 220 ],
);

is( dot_product($_->[0],$_->[1]), $_->[2] ) foreach @TESTS;

done_testing();

sub dot_product {
  my ($t,@y) = (0,@{$_[1]});
  $t += $_ * shift @y foreach @{$_[0]};
  $t;
}

