#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( reduce ) ;

sub gcd { #Euclid's algorithm!
  my $firstNum = shift ;
  my $secondNum = shift ;
  if ( $secondNum >= $firstNum ) {
      my $swapped = $firstNum ;
      $firstNum = $secondNum ;
      $secondNum = $swapped ;
  }
  while ( $firstNum != $secondNum ) {
      $firstNum = $firstNum - $secondNum ;
      if ( $secondNum >= $firstNum ) {
    my $swapped = $firstNum ;
    $firstNum = $secondNum ;
    $secondNum = $swapped ;
      }
  }
  return $firstNum ;
}

sub myPhi {
  my $number = shift ;
  my @totatives ;
  for my $i ( 1 .. $number - 1 ) {
      if ( gcd( $i , $number ) == 1 ) {
    push @totatives, $i ;
      }
  }
  return scalar( @totatives ) ;
}

sub isPerfectTotient {
  my $number = shift ;
  if ( $number == 1 ) {
      return 0 ;
  }
  my $start = $number ;
  my @totients ;
  do {
      $start = myPhi( $start ) ;
      push @totients, $start ;
  } until ( $start == 1 ) ;
  my $sum = reduce { $a + $b } @totients ;
  if ( $sum == $number ) {
      return 1 ;
  }
  else {
      return 0 ;
  }
}

my @perfectTotients ;
my $current = 1 ;
while ( scalar( @perfectTotients ) != 20 ) {
  if ( isPerfectTotient( $current ) ) {
      push @perfectTotients, $current ;
  }
  $current++ ;
}
say join( ',' , @perfectTotients ) ;
