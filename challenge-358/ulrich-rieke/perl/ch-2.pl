#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub convert {
   my $word = shift ;
   my $shift = shift ;
   my @numbers = map { ord( $_ ) } split( // , $word ) ;
   my @converted ;
   for my $num ( @numbers ) {
      my $shifted = $num + $shift ;
      if (( $shifted > 64 && $shifted < 91 ) || ( $shifted > 96 && $shifted < 123 ) ) {
         push( @converted , chr( $shifted ) ) ;
      }
      else {
         if ( $shifted > 90 && $shifted < 97 ) {
            push( @converted , chr( ($shifted % 91 ) + 65 ) ) ;
         }
         if ( $shifted > 122 ) {
            push( @converted , chr( ($shifted % 123) + 97 )) ;
         }
      }
   }
   return join( '' , @converted ) ;
}

say "Enter a word with ASCII alphabetic characters only!" ;
my $word = <STDIN> ;
chomp $word ;
say "Enter a positive integer!" ;
my $number = <STDIN> ;
chomp $number ;
say convert( $word , $number ) ;
