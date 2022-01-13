#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

sub isPrime {
  my $number = shift ;
  my $stop = sqrt( $number ) ;
  for my $i ( 2 .. floor( $stop )) {
      if ( $number % $i == 0 ) {
    return 0 ;
      }
  }
  return 1 ;
}

sub divideByHand {
  my $number = shift ;
  my $quotientstring = "0." ;
  my $num = 10 ;
  my $remainder = 0 ;
  while ( length( $quotientstring ) < (2 * ( $number - 1 ) + 2) ) {
      my $quot = int( $num / $number ) ;
      $quotientstring .= $quot ;
      $remainder = $num - $quot * $number ;
      if ( $remainder == 0 ) {
    last ;
      }
      if ( $quot == 0 ) {
    $num *= 10 ;
      }
      if ( $remainder != 0 ) {
    $num = $remainder * 10 ;
      }
  }
  return $quotientstring ;
}

my @longPrimes ;
my $current = 2 ;
while ( scalar( @longPrimes ) < 5 ) {
  my $quotient = divideByHand( $current ) ;
  if ( $quotient =~ /\A0\.(\d+)\z/ ) {
      my $afterPoint = $1 ;
      if ( length( $afterPoint ) == (2 * ( $current - 1 )) ) {
    my $half = int( length( $afterPoint ) / 2 ) ;
    if ( substr( $afterPoint, 0 , $half ) eq substr( $afterPoint , $half ) ) {
        push @longPrimes , $current ;
    }
      }
  }
  do {
      $current++ ;
  } while ( isPrime( $current ) == 0 ) ;
}
say join( ", " , @longPrimes ) ;
