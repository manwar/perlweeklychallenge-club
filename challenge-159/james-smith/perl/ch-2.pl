#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Math::Prime::Util qw(next_prime is_prime);

my @TESTS = (
  [  5, -1 ],
  [ 10,  1 ],
  [ 20,  0 ],
);

is( moebius(    $_->[0]), $_->[1] ) foreach @TESTS;
is( moebius_exp($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub moebius {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime($n);
  $n%($p**2) ? ($n%$p && ($r=-$r)) : return 0 while ($p = next_prime $p) < $n;
  $r;
}

sub moebius_exp {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime($n);
  while( ($p = next_prime $p ) < $n ) {
    return 0 unless $n%($p**2);
    $r=-$r unless $n%$p;
  }
  $r;
}

