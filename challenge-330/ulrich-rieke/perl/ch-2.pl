#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string with several words separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my @result ;
for my $w ( @words ) {
   if ( length( $w ) < 3 ) {
      push( @result , lc( $w ) ) ;
   }
   else {
      my $word = uc( substr( $w , 0 , 1 )) . lc( substr( $w , 1 ) ) ;
      push( @result , $word ) ;
   }
}
say join( ' ' , @result) ;
