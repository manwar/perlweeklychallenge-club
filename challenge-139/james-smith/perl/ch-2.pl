#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);

my( $N, @primes, @long_primes ) = ( $ARGV[0]||5 );

O: for( my $p=3; @long_primes<$N; $p+=2 ) {
  ($p % $_) || (next O) for @primes;
  push @long_primes, $p if $p - rec_len($p) == 1;
  push @primes,      $p;
}

say $_ for @long_primes;

sub rec_len {
  my( $D, $N, $s ) = ( shift, 1, '' );
  $s.=int($N/$D),$N%=$D,$N.=0 for 0..2*$D+length $D;
  $s =~ /(.+?)\1+$/ ? length $1 : 0;
}
