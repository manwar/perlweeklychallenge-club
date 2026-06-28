#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my $current = length $word ;
if ( $current == 0 ) {
   say '""' ;
}
else {
   $current-- ;
   my $reversed ;
   while ( $current != - 1 ) {
      $reversed .= substr( $word , $current , 1 ) ;
      $current-- ;
   }
   say $reversed ;
}
