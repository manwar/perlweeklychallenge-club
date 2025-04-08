#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s+/ , $line ) ;
my $len = scalar( @words ) ;
my $result = 1 ;
for my $i (0..$len - 2 ) {
   if ( substr( $words[$i] , length( $words[$i]) - 1 , 1 ) ne 
	 substr( $words[$i + 1] , 0 , 1 )) {
      $result = 0 ;
      last ;
   }
}
if ( $result == 1 ) {
   say "true" ;
}
else {
   say "false" ;
}
