#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = ( [101,86],[18,33] );

is( swap_nibble($_->[0]), $_->[1] ) foreach @TESTS;
is( swap_nibble($_->[1]), $_->[0] ) foreach @TESTS;

done_testing();

sub swap_nibble {
  return ($_[0]>>4) + (($_[0]&15)<<4);
}

