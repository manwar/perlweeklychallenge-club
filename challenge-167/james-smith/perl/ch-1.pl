#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(next_prime is_prime);

my($p,$N,$t,@res) = (1,19);

# Cannot raise $N above 10 as the 11th value is:
#   1,111,111,111,111,111,111
# which is 5.5 trillion times larger than the 10th value...

while(@res<$N) {
    ## Get the next prime - skip to next one if contains an even digit
    ## As each digit is used as the last digit we know that this is not
    ## a circular prime... (also skip 5 for a similar reason)
    ## Include exception for 1 digit primes { as we don't want to block
    ## 2 and 5 }
    ##
    ## We rotate the string n-1 times using the 4 parameter version of
    ## substr (twice), and Check $p is the lowest of the rotations
    ## We short cut where possible - if the value is larger than p
    ## of in the 2nd loop if the value is not prime...
    ## We then check to see if all are prime!
    ##
    ## We loop through                       17,981 primes
    ## reg filter removes    18,422 leaving     559 primes  (96.9%)
    ## lowest value filter      347 leaving     212 primes  (98.8%)
    ##
    ## Of these we check the following number of primes
    ##                  128 - 1 prime   =  128
    ##                   54 - 2 primes  =  108
    ##                   16 - 3 primes  =   48
    ##                    8 - 4 primes  =   32
    ##                    6 - 5 primes  =   30
    ##                                     346 total prime checks...
  ( ( $t = $p = next_prime $p ) < 10
    || $p !~ /[024568]/
    && ( ! grep { !is_prime( $_ )                             && (next)      }
           map  { ( substr$t,0,0,substr$t,-1,1,'' ) || $t < $p ? (next) : $t }
           2 .. length $p )
  ) && ( push @res, $p )
}

say for @res;
