#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my( $N,                   $p, @primes, @long_primes ) =
  ( @ARGV ? $ARGV[0] : 5, 1,  2 );

O: while( (@long_primes < $N) && ($p += 2) ) {
  ($p % $_) || (next O) for @primes; ## next if not prime...
  push @long_primes, $p if $p - rec_len($p) == 1;
  push @primes,      $p;
}

say $_ for @long_primes;

sub rec_len {
  my( $D, $N, $s ) = ( shift, 1, '' );
  ($s,$N) = $D>$N ? ($s.0, $N.0)
          : ($s.int($N/$D),($N%$D).0) for 0 .. 2*$D;
  $s =~ m{(\d+?)\1+$};
  length $1;
}
