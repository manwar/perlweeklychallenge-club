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
      my $root = sqrt( $number ) ;
      my $limit = floor( $root ) ;
      for my $i (2 .. $limit) {
    if ( $number % $i == 0 ) {
        return 0 ;
    }
      }
      return 1 ;
  }
}

sub primeFactorialize {
  my $number = shift ;
  my @possibleFactors ;
  my @factors ;
  if ( $number == 1 ) {
      push @factors , 1 ;
  }
  else {
      if ( isPrime( $number ) ) {
    push @factors, 1 , $number ;
      }
      else {
    @possibleFactors = grep { isPrime( $_ ) } (2 ..
          int( $number / 2 )) ; #pick all prime numbers from list of divisors
    push @factors, 1 ;
    while ( $number != 1 ) {
        my $nextFactor = shift @possibleFactors ;
        while ( $number % $nextFactor == 0 ) {#keep checking all prime factors
          push @factors, $nextFactor ;  #more than once
          $number /= $nextFactor ;
        }
    }
      }
  }
  return @factors ;
}

sub isSquareFree {
  my $number = shift ;
  my @primeFactors = primeFactorialize( $number ) ;
  my %factors ;
  for my $i ( @primeFactors ) {
      $factors{ $i }++ ;
  }
#if it is square free the number of different prime factors should be equal to
#the number of prime factors
  return scalar( keys %factors ) == scalar( @primeFactors ) ;
}

my @square_frees ;
my $current = 1 ;
while ( $current < 501 ) {
  if ( isSquareFree( $current ) ) {
      push @square_frees, $current ;
  }
  $current++ ;
}
say join( ',' , @square_frees ) ;
