#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Please enter a word consisting of lowercase English letters only!" ;
my $word = <STDIN> ;
chomp $word ;
my %frequencies ;
my $result = ' ' ;
#iterate through the letters of the word
#once you encounter one with 2 occurrences , end loop and output it
for my $letter( split( // , $word ) ) {
   $frequencies{$letter}++ ;
   if ( $frequencies{$letter} == 2 ) {
      $result = $letter ;
      last ;
   }
}
say $result ;
