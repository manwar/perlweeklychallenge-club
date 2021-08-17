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

say $_,' > ', get_triples($_) foreach 1..500;

sub get_triples {
  my $n = shift;
  return $n < 3 ? -1 : join '; ', map { sprintf '(%s)', join ', ', @{$_} }
  (
    grep { $_->[1] == int $_->[1] }                ## Check if all int
    map  { [ $_, sqrt($n**2-$_**2), $n ] }         ## Generate triple
    3 .. sqrt($n**2/2)                   ## Shortest side ($n is hypotenuse)
  ),(
    map  { $_->[0]>$_->[1] ? [@{$_}[1,0,2]] : $_ } ## put in numerical order
    grep { $_->[1] == int $_->[1] }                ## Check all int
    map  { [ $n, sqrt($_**2-$n**2), $_ ] }         ## Generate triple
    ($n+1) .. ($n**2/2+1)       ## Hypotenuse ($n is one of other two sides)
  );
}

## Notes:

# Except for $n < 3 there is always a solution
# * If $n is odd then it can always be the short side of a triangle where the
#   other sides are ($n^2-1)/2 or ($n^2+1)/2
# * If $n has an odd factor - then we can rewrite $n as $o * $m
#   we can use the same trick to get sides of $m($o^2-1)/2 & $m($o^2+1)/2
# * This only leaves us with numbers of the form 2^n - but we know that 4 can be part of a Pyth.Triple
#   and so any number of the form 2^($n+2) in a triple of the form ( 3.2^$n, 4.2^$n, 5.2^$n ).
#
# * We have two cases where $n is the hypotenuse and where it is a shorter side.
#   * With the former we need to look at the shorter sides these can be 3 -> n-1
#     but to avoid dupes we limit our search to sqrt(n^2/2)...
#   * The latter is more complex to work out the range
#     But we note that the difference between two consecutive squares is ($m+1)^2-($m)^2 = 2m + 1
#     So the largest value for the hypotenuse is therefore (n^2+1)/2

