#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( min ) ;

say "Enter some distinct integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @allCombis = combinations( \@numbers , 2 ) ;
my @differences ;
map { push( @differences , abs( $_->[0] - $_->[1] )) } @allCombis ;
my $minimum = min( @differences ) ;
my @selected = grep { abs( $_->[0] - $_->[1] ) == $minimum } @allCombis ; 
for my $pair ( @selected ) {
   print '[' . $pair->[0] . ',' . $pair->[1] . ']' ;
   if ( $pair != $selected[-1] ) {
      print " ," ;
   }
   else {
      say " " ;
   }
}
