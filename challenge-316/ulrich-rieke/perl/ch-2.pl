#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter two words , one shorter and one longer, separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my ($first , $second) = split( /\s+/ , $line ) ;
my $result = 1 ;
for my $c ( split( // , $first ) ) {
   my $pos = index( $second , $c ) ;
   if ( $pos != - 1 ) {
      $second = substr( $second , $pos ) ;
   }
   else {
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


