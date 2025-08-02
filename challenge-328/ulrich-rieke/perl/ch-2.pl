#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string with English letters!" ;
my $word = <STDIN> ;
chomp $word ;
my $solution ;
my $len = length( $word ) ;
my $pos = 0 ;
while ( $pos < $len ) {
   $solution .= substr( $word , $pos , 1 ) ;
   my $l = length( $solution ) ;
   if ( $l > 1 ) {
      my $first = substr( $solution , $l - 2  , 1 ) ;
      my $second = substr( $solution , $l - 1 , 1 ) ;
      if ( abs( ord( $first ) - ord( $second ) ) == 32 ) {
	 $solution = substr( $solution , 0 , $l - 2 ) ;
      }
   }
   $pos++ ;
}
if ( $solution ) {
   say $solution ;
}
else {
   say "\"\"" ;
}
