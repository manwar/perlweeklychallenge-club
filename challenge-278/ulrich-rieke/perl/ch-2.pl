#!/usr/bin/perl ;
use strict ;
use warnings ; 
use feature 'say' ;

say "Enter a word and a character, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
( my $haystack , my $needle ) = split( /\s+/ , $line ) ;
my $pos = index( $haystack , $needle ) ;
if ( $pos != -1 ) {
   my $firstPart = substr( $haystack , 0 , $pos + 1 ) ;
   my $sorted = join( '' , sort split( // , $firstPart ) ) ;
   if ( $pos + 1 < length $haystack ) {
      say ( $sorted . substr( $haystack , $pos + 1 ) ) ;
   }
   else {
      say $sorted ;
   }
}
else {
   say $haystack ;
}

