#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum product ) ;

sub factorial {
  my $number = shift ;
  if ( $number == 0 ) {
      return 1 ;
  }
  else {
      return product( 1 .. $number ) ;
  }
}

my $n = $ARGV[ 0 ] ;
my @digits = split( // , $n ) ;
if ( sum( map { factorial( $_ ) } @digits ) == $n ) {
  say 1 ;
}
else {
  say 0 ;
}
