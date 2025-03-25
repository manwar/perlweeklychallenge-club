#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum all min max ) ;

say "Enter 3 words separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my @firstLetters ;
#output is -1 if the first letters do not coincide
for my $word ( @words ) {
   push @firstLetters , substr( $word , 0 , 1 ) ;
}
if ( not ( all { $_ eq $firstLetters[0] } @firstLetters ) ) {
   say -1 ;
}
else {
   my @wordstarts ; #for the first letters of each word
   my $shortest = min( map { length $_ } @words ) ;#shortest word
   for my $i (1..$shortest ) {#find the beginning substrings
      my @substrings = map { substr( $_ , 0 , $i ) } @words ;
      if ( all{ $_ eq $substrings[0] } @substrings ) {
	 push @wordstarts , $substrings[0] ;
      }
   }
   my $maxcommon = max (map { length $_ } @wordstarts) ;#longest common substring
   say sum( map { length( $_ ) - $maxcommon } @words ) ;
}
