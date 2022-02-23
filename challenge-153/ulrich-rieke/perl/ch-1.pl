#!/usr/bin/perl ;
use strict ;
use warnings ;
use List::Util qw (product ) ;
use feature 'say' ;

sub factorial {
  my $number = shift ;
  if ( $number == 0 ) {
      return 1 ;
  }
  else {
      return product( 1 .. $number ) ;
  }
}

sub leftFactorial {
  my $number = shift ;
  my $sum = 0 ;
  map { $sum += factorial( $_ ) } (0 .. $number - 1 ) ;
  return $sum ;
}

my @leftFactorials ;
for my $i (1 .. 10) {
  push @leftFactorials , leftFactorial( $i ) ;
}
say join( ',' , @leftFactorials) ;
