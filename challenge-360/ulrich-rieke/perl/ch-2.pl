#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub to_lower_case {
   my $word = shift ;
   my @revised ;
   for my $letter( split( // , $word ) ) {
      if ( ord( $letter ) > 64 && ord( $letter ) < 91 ) {
         push( @revised , chr( ord( $letter ) + 32 ) ) ;
      }
      else {
         push( @revised , $letter ) ;
      }
   }
   return join( '' , @revised ) ;
}

say "Enter a sentence!" ;
my $line = <STDIN> ;
chomp $line ;
my @sorted = sort { to_lower_case( $a ) cmp to_lower_case( $b ) } split(
      /\s+/ , $line ) ;
say join( ' ' , @sorted ) ;

