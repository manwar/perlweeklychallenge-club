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
## The following are good examples where the second algorithm works well!
  [ 2,   -1 ],
  [ 6,   1 ],
  [ 30,   -1 ],
  [ 210,   1 ],
  [ 2310,   -1 ],
  [ 30030,   1 ],
  [ 510510,  -1 ],
  [ 9699690, 1 ],
  [ 6895531,   -1 ],
  [ 206865930,  1 ],
  [ 223092870, -1 ],
  [ 6469693230, 1 ],
);

warn "exp";
is( moebius_exp(     $_->[0] ), $_->[1] ) for @TESTS;
warn "opt";
is( moebius_div_opt( $_->[0] ), $_->[1] ) for @TESTS;
#timethis( 500_000, sub { moebius_div_opt( $_->[0] ) for @TESTS } );
exit;
warn "div";
is( moebius_div(     $_->[0] ), $_->[1] ) for @TESTS;
timethis(     100, sub { moebius_div(     $_->[0] ) for @TESTS } );
warn "dumb";
is( moebius(         $_->[0] ), $_->[1] ) for @TESTS;
timethis(       5, sub { moebius(         $_->[0] ) for @TESTS } );

done_testing();

sub moebius {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime($n);
  $n%($p**2) ? ($n%$p || ($r=-$r)) : return 0 while ($p = next_prime $p) <= $n;
  $r;
}

sub moebius_div {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime $n;
  $n%($p**2) ? ( $n%$p || ($r=-$r,$n/=$p)) : return 0 while ($p = next_prime $p) && $n>1;
  $r;
}

sub moebius_div_opt {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime $n;
  $n%$p || ($n/=$p) && $n%$p ? ( is_prime $n ? (return $r) : ($r=-$r) ) : return 0 while ($p = next_prime $p)**2 <= $n;
  $r;
}

sub moebius_exp {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime $n;
  while( ($p = next_prime $p )**2 <= $n ) {
    next if $n%$p;
    $r=-$r;
    $n/=$p;
    return 0 unless $n%$p;
    return -$r if is_prime $n;
  }
  $r;
}

