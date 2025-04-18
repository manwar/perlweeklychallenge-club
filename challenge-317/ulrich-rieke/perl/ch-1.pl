#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some words separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s+/ , $line ) ;
say "Enter a second word!" ;
my $comparison = <STDIN> ;
chomp $comparison ;
my $firstLetters ;
map { $firstLetters .= substr( $_ , 0 , 1 ) } @words ;
if ( $firstLetters eq $comparison ) {
   say "true" ;
}
else {
   say "false" ;
}
