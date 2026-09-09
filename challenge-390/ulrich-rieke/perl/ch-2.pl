#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#it appears that in all cases where k is greater than 1 we go through all 
#the permutations of the letters. At least, this looks like holding true
#for the examples given. In all cases where k is greater than 1 it appears
#to suffice to find the lexicographically smallest word.
sub contains {
   my $array = shift ;
   my $word = shift ;
   for my $elt( @$array ) {
      if ( $elt eq $word ) {
         return 1 ;
      }
   }
   return 0 ;
}

say "Enter an alphabetical word and a number separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $startword , $k ) = split( /\s/ , $line ) ;
if ( $k == 1 ) {
   my @permus ;
   push( @permus , substr( $startword , 1 ) . substr( $startword , 0 , 1 ) ) ;
   while ( not contains( \@permus , $startword ) ) {
      push( @permus , substr( $permus[-1] , 1 ) . substr( $permus[-1] , 0 , 
               1 ) ) ;
   }
   my @sorted = sort @permus ;
   say $sorted[0] ;
}
else {
   my $smallest = join( '' , sort split( // , $startword )) ;
   say $smallest ;
}
