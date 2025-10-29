#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter at least 3 integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @indices ;
for my $pos( 1..scalar( @numbers) - 2 ) {
   if ( $numbers[$pos] > $numbers[$pos - 1] && $numbers[$pos] > $numbers[$pos + 1] ) {
      push( @indices , $pos ) ;
   }
}
say '(' . join( ',' , @indices ) . ')' ;
