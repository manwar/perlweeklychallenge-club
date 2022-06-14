#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub primeDecompose {
  my $number = shift ;
  my $current = 2 ;
  my @primeFactors ;
  while ( $number != 1 ) {
      if ( $number % $current == 0 ) {
        push @primeFactors, $current ;
        $number /= $current ;
      }
      else {
        $current++ ;
      }
  }
  return @primeFactors ;
}

sub isBrilliant {
  my $number = shift ;
  my @primeFactors = primeDecompose( $number ) ;
  return ( (scalar( @primeFactors ) == 2 ) && ( length( $primeFactors[0] )
        == length( $primeFactors[1] ))) ;
}

my @brilliantNumbers ;
my $current = 1 ;
while ( scalar( @brilliantNumbers ) != 20 ) {
  if ( isBrilliant( $current ) ) {
      push @brilliantNumbers , $current ;
  }
  $current++ ;
}
say join( ',' , @brilliantNumbers ) ;
