#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use bigint;

my( $N, @primes, @long_primes ) = ( $ARGV[0]||5 );

##
## We know 2 isn't a long prime, and also we are
## only looking at odd numbers so we don't have
## to worry about the special case of 2.
##
## Starting at the 3 we loop through the odd numbers
## Looking to see if the number is composite {has
## at least 1 prime factor lower than $p}.
##
## Skip to next number if it is (line 2)
##
## If it has the long_prime property we add it
## to the list of long primes (line 3)
## We also add it to the primes list (line 4)
##
## We exit the loop when we have the appropriate
## number of long primes
##

O: for( my $p=3; @long_primes<$N; $p+=2 ) {
  ($p % $_) || (next O) for @primes;
  push @long_primes, $p if $p - rec_len($p) == 1;
  push @primes,      $p;
}


##
## Output the long primes
##

say $_ for @long_primes;

##
## We use long division here to compute the reciprocal
## of $D, to ensure we get a repeating pattern - we
## compute the 2$D + length $D digits as the repeating
## pattern will comprise of a number of 0s followed by
## the repeating pattern (which has to be at least
## 2$D-2 long.
##
## This division is done in line 2.
##
## The 3rd line finds the shortest repeating sequence
## tied to the end of this string, and returns its
## length
##
sub rec_len {
  my( $D, $N, $s ) = ( shift, 1, '' );
  $s.=int($N/$D),$N%=$D,$N.=0 for 0..2*$D+length $D;
  $s =~ /(.+?)\1+$/ ? length $1 : 0;
}
