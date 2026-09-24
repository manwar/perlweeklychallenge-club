#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isPalindrome {
   my $word = shift ;
   if (join( '' , reverse split( // , $word )) eq $word) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
if ( isPalindrome( $word ) ) {
   say $word ;
}
else {
   my $maxi = 1 ;
   my $len = length( $word ) ;
   for my $howmany( 2..$len - 1) {
      my $sub = substr( $word , 0 , $howmany ) ;
      if ( isPalindrome( $sub ) ) {
         if ( $howmany - 1 > $maxi ) {
            $maxi = $howmany - 1 ;
         }
      }
   }
   my $rest ;
   if ( $maxi == 1 ) {
      $rest = substr( $word , $maxi ) ;
   }
   else {
      $rest = substr( $word , $maxi + 1 ) ;
   }
   my $reversed = join( '' , reverse split( // , $rest )) ;
   say $reversed . $word ;
}
