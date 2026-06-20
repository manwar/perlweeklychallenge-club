#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub toNumber {
   my $word = shift ;
   return join( '' , map { ord( $_ ) - 97 } split( // , $word )) ;
}

say "Enter 3 strings consisting of lowercase English letters from a to j!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my @numbers = map { toNumber( $_ ) } @words ;
if ( $numbers[0] + $numbers[1] == $numbers[2] ) {
   say "true" ;
}
else {
   say "false" ;
}
