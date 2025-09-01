#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my @solution ;
for my $pos ( 0..scalar( @numbers ) - 1 ) {
   my $count = scalar( grep { $_ <= $numbers[$pos] } @numbers ) ;
   if ( $count > 0 ) {
      push( @solution , $count - 1 ) ;
   }
   else {
      push( @solution , 0 ) ;
   }
}
say '(' . join( ',' , @solution ) . ')' ;
