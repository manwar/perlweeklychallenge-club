#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

sub isPrime {
  my $number = shift ;
  if ( $number == 1 ) {
      return 0 ;
  }
  elsif ( $number == 2 ) {
      return 1 ;
  }
  else {
      my $root = ceil( sqrt( $number ) ) ;
      for my $i ( 2 .. $root ) {
        if ( $number % $i == 0 ) {
            return 0 ;
        }
      }
      return 1 ;
  }
}

my @cubanPrimes ;
my $current = 0 ;
do {
  $current++ ;
  my $sum = 3 * $current ** 2 + 3 * $current + 1 ;
  if ( isPrime( $sum ) ) {
      push @cubanPrimes , $sum ;
  }
} until ( $cubanPrimes[-1] > 1000 ) ;
say join( ',' , @cubanPrimes[0 .. scalar( @cubanPrimes ) - 2]) ;
