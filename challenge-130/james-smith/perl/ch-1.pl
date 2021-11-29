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

is( find_odd_not($_->[0]), $_->[1] ) foreach @TESTS;
is( find_odd_xor($_->[0]), $_->[1] ) foreach @TESTS;
is( find_odd_sum($_->[0]), $_->[1] ) foreach @TESTS;

cmpthese(100_000,{
  'sum' => sub { find_odd_sum( $_->[0] ) foreach @TESTS; },
  'xor' => sub { find_odd_xor( $_->[0] ) foreach @TESTS; },
  'not' => sub { find_odd_not( $_->[0] ) foreach @TESTS; },
});

done_testing();

sub find_odd_sum {
  my %x;
  $x{$_}++ foreach @{$_[0]};
  return ( grep { $x{$_} & 1 } keys %x )[0];
}

sub find_odd_xor {
  my %x;
  $x{$_}^=1 foreach @{$_[0]};
  return ( grep { $x{$_} } keys %x )[0];
}

sub find_odd_not {
  my %x;
  $x{$_} = !$x{$_} foreach @{$_[0]};
  return ( grep { $x{$_} } keys %x )[0];
}

