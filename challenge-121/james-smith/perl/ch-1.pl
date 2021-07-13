#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 12, 3, 8 ],
  [ 18, 4, 26 ],
);

is( flip_bit($_->[0],$_->[1]), $_->[2] ) foreach @TESTS;
is( flip_bit($_->[2],$_->[1]), $_->[0] ) foreach @TESTS;

done_testing();

sub flip_bit {
  return $_[0] ^ 1<<$_[1]-1;
}

