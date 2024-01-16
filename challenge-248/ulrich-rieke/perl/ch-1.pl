#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

say "Enter a string and a letter from this string , separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @parts = split( /\s+/ , $line ) ;
my $string = $parts[0] ;
my $letter = $parts[ 1 ] ;
my @letterpositions ;
my $pos = 0 ;
for my $current ( split( // , $string ) ) {
   if ( $current eq $letter ) {
      push @letterpositions , $pos ;
   }
   $pos++ ;
}
my @result ;
$pos = 0 ;
for my $current ( split( // ,  $string )) {
   if ( $current ne $letter ) {
      my @distances = map { abs( $pos - $_ ) } @letterpositions ;
      push @result , min( @distances ) ;
   }
   else {
      push @result , 0 ;
   }
   $pos++ ;
}
say ( "(" . join( ',' , @result) . ")" ) ;

