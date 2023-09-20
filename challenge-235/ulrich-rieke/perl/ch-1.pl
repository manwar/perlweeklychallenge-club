#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
#we can form $len - 1 pairs of neighbouring pairs. Every one bar one must be strictly
#increasing!
my $pairnumber = $len - 1 ;
my $count = 0 ; #how many neighbouring pairs are strictly increasing?
for my $pos( 0..$len - 2) {
   if ( $numbers[ $pos + 1 ] > $numbers[ $pos ] ) {
      $count++ ;
   }
}
if ( $count == $pairnumber - 1) {
   say "true" ;
}
else {
   say "false" ;
}
