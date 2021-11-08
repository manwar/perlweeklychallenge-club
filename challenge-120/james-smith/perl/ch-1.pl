#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 101, 154 ],
  [ 18, 33 ],
);

is( switch_bits($_->[0]), $_->[1] ) foreach @TESTS;
is( switch_bits($_->[1]), $_->[0] ) foreach @TESTS;

done_testing();

## Similar to last weeks calculation. We and
## with 10101010 to get the higher bits and
## with 01010101 to get the lower bits...
## and use bit shift operators to move them
## left and right respectively.
sub switch_bits {
  ($_[0]&0xaa)>>1 | ($_[0]&0x55)<<1;
}

