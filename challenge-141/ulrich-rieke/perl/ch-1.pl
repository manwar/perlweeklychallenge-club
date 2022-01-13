#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findDivisors {
  my $number = shift ;
  return grep { $number % $_ == 0 } (1 .. $number) ;
}

my @wanted ;
my $current = 1 ;
while ( scalar( @wanted ) < 10 ) {
  my @divisors = findDivisors( $current ) ;
  if ( scalar( @divisors ) == 8 ) {
      push @wanted , $current ;
  }
  $current++ ;
}
say join( ', ' , @wanted ) ;
