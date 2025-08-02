#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a long integer!" ;
my $number = <STDIN> ;
chomp $number ;
my $pos = 0 ;
my @triplets ;
my @selected ;
while ( $pos < length( $number ) - 2 ) {
   push( @triplets , substr( $number , $pos , 3 ) ) ;
   $pos += 1 ;
}
@selected = grep { substr( $_ , 0 , 1 ) eq substr( $_ , 1 , 1 ) && 
   substr( $_ , 1 , 1 ) eq substr( $_ , 2 , 1 ) } @triplets ;
if ( scalar( @selected ) > 0 ) {
   say substr( $selected[0] , 0 , 1 ) ;
}
else {
   say -1 ;
}
