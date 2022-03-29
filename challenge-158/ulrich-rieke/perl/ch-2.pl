#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;
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

sub isAdditivePrime {
  my $number = shift ;
  my $sum = sum( split ( // , $number )) ;
  return isPrime( $number ) && isPrime( $sum ) ;
}

my @additivePrimes ;
my $current = 1 ;
do {
  $current++ ;
  if ( isAdditivePrime( $current ) ) {
      push @additivePrimes , $current ;
  }
} until ( $additivePrimes[-1] > 100 ) ;
say join( ',' , @additivePrimes[0 .. scalar( @additivePrimes) - 2] ) ;
