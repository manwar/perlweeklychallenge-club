#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;
use POSIX ;

sub contains {
   my $array = shift ;
   my $element = shift ;
   for my $elt( @$array ) {
      if ( $elt == $element ) {
         return 1 ;
      }
   }
   return 0 ;
}

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ; 
my @numbers = split( /\s/ , $line ) ;
my $average = ( sum( @numbers )) / scalar( @numbers ) ;
my $ceil = ceil( $average ) ;
my $current ;
if ( $ceil == $average ) {
   $current = $average + 1 ;
}
else {
   if ( $ceil < 0 ) {
      $current = $ceil + 1 ;
   }
   else {
      $current = $ceil ;
   }
}
while ( $current <= 0 ) {
   $current++ ;
}
while ( contains( \@numbers , $current ) ) {
   $current++ ;
}
say $current ;
