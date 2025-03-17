#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $firstWord = <STDIN> ;
chomp $firstWord ;
say "Enter a second word with possible typing errors!" ;
my $secondWord = <STDIN> ;
chomp $secondWord ;
my %firstLetters ;
my %secondLetters ;
map { $firstLetters{$_}++ } split ( // , $firstWord ) ;
map { $secondLetters{$_}++ } split( // , $secondWord ) ;
if ( keys( %firstLetters ) ~~ keys( %secondLetters ) &&
      length( $firstWord ) != length( $secondWord ) ) {
   say "true" ;
}
else {
   say "false" ;
}
