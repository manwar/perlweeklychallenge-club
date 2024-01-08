#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @selected ;
for my $pos ( 0..scalar( @numbers ) - 1 ) {
   if ( $pos % 10 == $numbers[ $pos ] ) {
      push @selected , $pos ;
   }
}
if ( @selected ) {
   say min( @selected ) ;
}
else {
   say -1 ;
}
