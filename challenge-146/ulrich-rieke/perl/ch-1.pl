#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isPrime {
  my $number = shift ;
  return 1 if ( $number == 2 ) ;
  for my $i ( 2..int( $number / 2 ) ) {
      return 0 if $number % $i == 0 ;
  }
  return 1 ;
}

my $current = 1 ;
my $num_of_primes = 0 ;
do {
  $current++ ;
  if ( isPrime( $current ) ) {
      $num_of_primes++ ;
  }
} while ( $num_of_primes != 10001 ) ;
say $current ;
