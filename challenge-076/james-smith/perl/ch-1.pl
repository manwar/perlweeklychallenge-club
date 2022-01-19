#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 0, 1 ],
);

is( my_function($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub my_function {
  return 1;
}

