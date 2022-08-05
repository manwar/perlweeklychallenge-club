#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my $t=123_455;

O: while( my $z = join '', sort split //, ++$t ) {
  ( $z eq join '', sort split //, $_*$t ) || next O for 2..6;
  last;
die if $t > 166666;
}

say $t;

## Now we will use a 2nd approach - this uses the fact
## that for long primes the multiples all contain the
## same digits - if you including leading zeros.
##
## We can ignore the leading zeros and start with numbers
## beginning in 1
##
## We use the long prime code from challenge 139 to work
## out which are the long primes, and this gives us a
## single exemplar for the rotation. We then re-order this
## to get the numbers which start with 1 and when multiplied
## by 6 have the same length.
##
## In this case they start with a "1" and are less than
## "1" followed by p-2 "6"s - faster as we don't need to
## big ints...

my($N,$p,$c,@primes) = ($ARGV[0]//20,1,0);
                                     ## $N is the number of long
                                     ## primes to generate....
                                     ## $p is the start for prime
                                     ## scan - basically we
                                     ## search for odd primes
                                     ## we know 2 is not valid
                                     ## in this case....
                                     ## $c is just a counter...

Z: for ( 1 .. $N ) {
  $p+=2;
  ($p % $_) || (redo Z) for @primes; ## Check that the number
                                     ## is a prime if not
                                     ## restart loop
  push @primes, $p;                  ## Record prime...
  my($N,$s) = (1,'');
  $s.=int($N/$p),$N%=$p,$N.=0 for 0..2*$p+length $p;
                                     ## Generate the repeating
                                     ## sequence of 1/$p
  redo unless $s =~ /(.+?)\1+$/;     ## Redo if not repeating...
  redo if $p-1-length $1;            ## Redo if the sequence is
                                     ## not of length $p-1
  my( $tc, $cr, $th ) = ($c,$1,'1'.('6' x ($p-2) ));
                                     ## $cr - digits to rotate
                                     ## $th - threshold for
                                     ##   6 * v rolls over for
                                     ##   extra digit 16666....
                                     ## $tc is just so we can
                                     ## have a 2nd counter
  say join "\t", ++$c, $c-$tc, $p-1, $_ for sort
    grep { $th gt $_ }               ## All values less than 1666...
    grep { '1' eq substr $_,0,1  }   ## All values start with 1
    map  { substr $cr, 0, 0, substr $cr,-1,1,''; $cr }
                                     ## rotate $cr using 4 parameter
                                     ## substr
    1..$p-1;
}

