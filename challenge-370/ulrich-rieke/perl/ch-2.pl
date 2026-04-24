#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#strings are scrambled if you find at least one split point , where either the first
#and second parts are anagrams or the first and second part respectively
#strings are anagrams if they contain the same numbers in the same frequency

sub isAnagram {
   my $firstWord = shift ;
   my $secondWord = shift ;
   my $firstRearranged = join( '' , sort split( // , $firstWord )) ;
   my $secondRearranged = join( '' , sort split( // , $secondWord )) ;
   if ( $firstRearranged eq $secondRearranged ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

sub isScrambled {
   my $firstWord = shift ;
   my $secondWord = shift ;
   my $len = length( $firstWord ) ;
   for my $i (1..$len - 2 ) {
      if ( (isAnagram( substr( $firstWord , 0 , $i ) , substr( $secondWord , 0 , $i ))
            && (isAnagram( substr( $firstWord , $i ) , substr( $secondWord , $i ) ) )) 
         || ( isAnagram( substr( $firstWord , $i ) , substr( $secondWord , 0 , $i ))
               && isAnagram( substr( $firstWord , 0 , $i ) , substr( $secondWord , $i )))) {
            return 1 ;
         }
   }
   return 0 ;
}
say "Enter two words of equal length!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
if ( isScrambled( $words[0] , $words[1] ) ) {
   say "true" ;
}
else {
   say "false" ;
}
