#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a term consisting of English letters only!" ;
my $term = <STDIN> ;
chomp $term ;
my $changed ;
for my $letter( split( // , $term ) ) {
   if ( $letter =~ /[a-z]/ ) {
      $changed .= uc( $letter ) ;
   }
   else {
      $changed .= lc( $letter ) ;
   }
}
say $changed ;
