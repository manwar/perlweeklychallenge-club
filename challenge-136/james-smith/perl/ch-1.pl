#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [31,96],  0 ],
  [ [8,24],   1 ],
  [ [26,39],  0 ],
  [ [4,10],   1 ],
);

is( friendly(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub friendly {
  my($a,$b) = @_;
  ($a,$b) = ($b,$a%$b) while $b; ## Get GCD
  return 0 if $a == 1;           ## Numbers are co-prime so not friendly
  $a>>=1 until $a&1;             ## Remove trailing binary 0 digits
  return $a == 1 ? 1 : 0;        ## For powers of two $a == 1
}

