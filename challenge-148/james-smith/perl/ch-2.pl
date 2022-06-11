#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

## All solutions where $a < 10,000

## The problem can be re-written as:
##   8.a^3 + 15.a^2 + 6.a - 27.b^2.c = 1
## Further mode if we re-write:
##   a = 3.k - 1
## Then this further reduces to:
##   b^2.c = k^2 . (8.k-3)
## Where k starts at 1

## This greatly reduces the time it takes to calculate the triplets.

## We loop over $k from 1 .. ($N+1)/3 ## We then loop of $b until such
## time as the calculated value of $c < 1
##
## In this case it is (8*$k-3)*$k*$k / $b*b
##
## Trying to avoid issues with rounding due to division we can change
## this to just
##   (8*$k-3).$k*$k < $b*$b
##
## Check to see if the value of $c is an integer and if so display it.
##
## It is an integer if $n%$d is zero. Again saves rounding error issues


for my $k (1..333) {
  for( my ($b, $n) = (1, $k*$k*(8*$k-3) ); $n > $b*$b; $b++ ) {
    say join "\t", 3*$k-1,$b,$n/$b/$b unless $n%($b*$b);
  }
}

## To check the values are truly a Cardano triplet I wrote this
## function.

sub is_card {
  my($a,$b,$c) = @_;
  return abs( cr($a+$b*sqrt$c) + cr($a-$b*sqrt$c) - 1 ) < 0.000001;
}

## To get the cube route - the code would fail if the value
## was negative. The following works by finding the cube
## root of the absolute value. And multiplying by -1 if negative

sub cr {
  return $_[0] < 0 ? -(-$_[0])**(1/3) : $_[0]**(1/3);
}
