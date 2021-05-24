#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(timethis cmpthese);

my @ex = ( [25,8,0], [25,7,0], [24,7,1], [24,0,0], [10,0,1], [28,8,1], [26,8,1], [16,8,0], [441,9,1], [431,9,1] );

is( represent(          $_->[0], $_->[1]), $_->[2] ) foreach @ex;
is( represent_unrolled( $_->[0], $_->[1]), $_->[2] ) foreach @ex;

## In this challenge we make the assumption that the numbers
## that need to be added are all different. This was not made
## clear in the question itself - but I think that this was
## implicit.

done_testing();

say '';
cmpthese( 1_000_000,{
  'rolled'   => sub { represent(          $_->[0], $_->[1] ) for @ex },
  'unrolled' => sub { represent_unrolled( $_->[0], $_->[1] ) for @ex },
});
say '';

sub represent {

  my( $t, $n, $d ) = ( 0, @_ );

  ## If $d is equal to 0
  ##   Any number between 100 & 109 can be represented by itself
  ##   For numbers over 109 we can represent these as 100-109 + a
  ##   number ending in 0...
  ##   e.g. 534 / 0 = 104 + 430
  ##
  ##   So if $d is equal to 0 then all numbers > 100 are possible
  ##
  ## If $n is between 10*$d and 10*$d+9 then it can be represented as $d$x
  ##   For numbers > than this we can do a similar trick to above
  ##   We can reprent them as a number ending in $d and a number
  ##   where $d is the penultimate digit
  ##
  ##   e.g. 107 & 9 =   **9** +  **9**8
  ##   e.g. 450 & 8 =  6**8** + 3**8**2
  ##   e.g. 435 & 2 =  1**2** + 4**2**3
  ##
  ##   So if $d is not equal to 0 then all numbers greater than 10x$d
  ##   are possible

  return 1 if $n >= 10 * ( $d || 10 );

  ## Finally we get to the list of numbers less than this - as the only
  ## digit that can contain $d is the last one we just try to see if
  ## we can find a sum of numbers ending in $d which have the same last
  ## digit as $n and less than or equal to $n. Note as we have already
  ## removed the numbers greater than 100 we now we only need to loop
  ## up to 3 - as the next number would be 100 + 4$d....

  ## Return 1 if both conditions hold true...

  $n >= ( $t += $_ * 10 + $d ) &&
    ( $n % 10 == $t % 10 ) && return 1 for 0..3;

  ## Return 0 if no solution is possible...

  0;
}

sub represent_unrolled {
  my( $n, $d ) = @_;

## We can speed things up by a factor of 50% by unrolling the
## for loop and so we can reduce the test to the following -
## representing the check for the first type of solution and
## then the 4 checks within the loop...

  $n >= 10 * ( $d || 10 )                      ||
  $n >= $d                && $n%10 == $d       ||
  $n >= 2*$d+10           && !( ($n-2*$d)%10 ) ||
  $n >= 3*$d+30           && !( ($n-3*$d)%10 ) ||
  $n >= 4*$d+60           && !( ($n-4*$d)%10 ) ? 1 : 0;
}

