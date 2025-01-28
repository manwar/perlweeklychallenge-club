#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
while ( scalar( @numbers ) > 1 ) {
   @numbers = sort { $a <=> $b } @numbers ;
   if ( $numbers[-1] == $numbers[-2] ) {
      pop @numbers ;
      pop @numbers ;
   }
   else {
      $numbers[ -1] = $numbers[ -1 ] - $numbers[-2] ;
      my $len = scalar( @numbers ) ;
      splice( @numbers , $len - 2 , 1 ) ;
   }
}
if ( scalar( @numbers ) == 1 ) {
   say $numbers[0] ;
}
else {
   say 0 ;
}
