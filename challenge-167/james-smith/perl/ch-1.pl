#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Math::Prime::Util qw(next_prime is_prime);

my($p,$N,@res) = (99,10);

# Cannot raise $N above 10 as the 11th value is:
#   1,111,111,111,111,111,111
# which is 5.5 trillion times larger than the 10th value...

O: while( @res < $N ) {
    ## Get the next prime - skip to next one if contains an even digit
    ## As each digit is used as the last digit we know that this is not
    ## a circular prime... (also skip 5 for a similar reason)
  next O if ($p = next_prime $p)=~/[024568]/;
    ## Split the string into consituent numbers...
  my @q = split//, $p;
    ## Check $p is the lowest of the permutations
    ## Here @q starts out as the list of digits - but gets assigned the
    ## list of rotations... This avoids us using a cache to see if we
    ## have seen that combination of digits - slower but more memory
    ## efficient...
    ## If it is we then check to see if all are prime!
  push @res, $p unless
    ( grep { $p>$_ } @q = map { push @q, shift @q; join '',@q } 2..@q )
    || grep { !is_prime( $_ ) } @q;
}
say for @res;

