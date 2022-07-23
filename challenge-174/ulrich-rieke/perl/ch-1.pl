#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isDisarium {
  my $number = shift ;
  my $sum = 0 ;
  my @digits = split( // , $number ) ;
  for my $i ( 1 .. scalar( @digits ) ) {
      $sum += $digits[ $i - 1 ] ** $i ;
  }
  return $sum == $number ;
}

my @disariums ;
my $current = 0 ;
while ( scalar( @disariums ) != 19 ) {
  if ( isDisarium( $current ) ) {
      push @disariums, $current ;
  }
  $current++ ;
}
say join( ',' , @disariums ) ;
