#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Math::BigInt ;

my $x = Math::BigInt->new( "2" ) ;
say $x ;
my $y = Math::BigInt->new( "3" ) ;
say $y ;
my $lastProduct = $x->bmul($y)->copy( ) ;
my $count = 0 ;
while ( $count != 8 ) {
  my $newElement = $lastProduct->copy( ) ;
  $newElement->binc( ) ;
  say $newElement ;
  $lastProduct->bmul( $newElement ) ;
  $count++ ;
}
