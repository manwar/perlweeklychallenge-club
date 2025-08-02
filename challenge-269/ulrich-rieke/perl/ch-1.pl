#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some distinct integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp( $line ) ;
my @numbers = split( /\s+/ , $line ) ;
my @arr1 ;
my @arr2 ;
my @removed = splice( @numbers , 0 , 1 ) ;
push( @arr1 , $removed[ 0 ] ) ;
@removed = splice( @numbers , 0 , 1 ) ;
push( @arr2, $removed[ 0 ] ) ;
while ( @numbers ) {
   @removed = splice( @numbers, 0 , 1 ) ;
   if ( $arr1[-1] > $arr2[-1] ) {
      push( @arr1 , $removed[ 0 ] ) ;
   }
   else {
      push( @arr2 , $removed[ 0 ] ) ;
   }
}
push( @arr1 , @arr2 ) ;
say "(" . join( ',' , @arr1 ) . ")" ;
