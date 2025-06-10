#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter some 0 and 1 separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $ones = 0 ;
my @groups ;
for my $n ( @numbers ) {
   if ( $n == 1 ) {
      $ones++ ;
   }
   else {
      if ( $ones > 0 ) {
	 push( @groups, $ones ) ;
	 $ones = 0 ;
      }
   }
   if ( $ones > 0 ) {
      push( @groups , $ones ) ;
   }
}
if ( @groups ) {
   say max( @groups ) ;
}
else {
   say 0 ;
}
