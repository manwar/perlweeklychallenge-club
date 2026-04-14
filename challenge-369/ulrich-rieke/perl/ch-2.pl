#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string , a size and a filler separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $string , $size , $filler ) = split( /\s/ , $line ) ;
my $start = 0 ;
my $len = length( $string ) ;
my @output ;
while ( $start < $len ) {
   if ( $start + $size < $len ) {
      push( @output , substr( $string , $start , $size ) ) ;
   }
   else {
      push( @output , substr( $string , $start ) ) ;
   }
   $start += $size ;
}
my $last = $output[-1] ;
if ( length( $last ) < $size ) {
   $last .= ( $filler x ( $size - ( length( $last ) ) ) ) ;
   pop( @output ) ;
   push( @output , $last ) ;
}
say '(' . join( ',' , @output ) . ')' ;


