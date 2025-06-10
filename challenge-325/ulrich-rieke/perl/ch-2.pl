#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some prices separated by blanks!" ;
my $priceline = <STDIN> ;
chomp $priceline ;
my @prices = split( /\s/ , $priceline ) ;
my $len = scalar( @prices ) ;
my @solution ;
for my $pos (0..$len - 2 ) {
   my @followers = grep { $_ <= $prices[$pos] } @prices[$pos + 1 .. $len - 1] ;
   if ( @followers ) {
      push ( @solution , $prices[$pos] - $followers[0] ) ;
   }
   else {
      push( @solution , $prices[$pos] ) ;
   }
}
push( @solution , $prices[-1] ) ;
say '(' . join( ',' , @solution ) . ')' ;
