#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

sub findDivisors {
  my $number = shift ;
  my @divisors ;
  for my $i ( 1 .. int( $number / 2 ) ) {
      if ( $number % $i == 0 ) {
    push @divisors , $i ;
      }
  }
  return @divisors ;
}

sub isAbundant {
  my $number = shift ;
  my @divisors = findDivisors( $number ) ;
  return sum( @divisors ) > $number ;
}

my @oddAbundant ;
my $current = 3 ;
while ( scalar( @oddAbundant ) != 20 ) {
  if ( isAbundant( $current ) ) {
      push @oddAbundant , $current ;
  }
  $current += 2 ;
}
say join( ',' , @oddAbundant ) ;
