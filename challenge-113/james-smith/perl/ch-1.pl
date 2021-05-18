#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(timethis);

my @ex = ( [25,8,0], [25,7,0], [24,7,1], [24,0,0], [10,0,1], [28,8,1], [26,8,1], [16,8,0], [441,9,1], [431,9,1] );

is( represent( $_->[0], $_->[1]), $_->[2] ) foreach @ex;

done_testing();
say '';
timethis( 1_000_000, sub { represent($_->[0],$_->[1]) for @ex } );
say '';
sub represent {
  my($t,$n,$d) = (0,@_);
  ## If $d is equal to 0
  ##   Any number between 100 & 109 can be represented by itself
  ##   For numbers over 109 we can represent these as 100-109 + a
  ##   number ending in 0...
  ## If $n is between 10*$d and 10*$d+9 then it can be represented as $d$x
  ##   For numbers > than this we can do a similar trick to above
  ##   We can reprent them as $d$x + a number ending in $d
  return 1 if $n >= 10 * ($d||10);
  ## Finally we get to the list of numbers less than this - as the only
  ## digit that can contain $d is the last one we just try to see if
  ## we can find a sum of numbers ending in $d which have the same last
  ## digit as $n and less than or equal to $n.
  $n>=($t+=$_*10+$d) && ($n%10 == $t%10) && return 1 for 0..9;
  0;
}

