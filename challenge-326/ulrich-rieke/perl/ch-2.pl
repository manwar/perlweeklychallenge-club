#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an even amount of positive integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my @solution ;
my $pos = 0 ;
while ( $pos < $len - 1 ) {
   my $howmany = $numbers[$pos] ;
   for (0..$howmany - 1) {
      push( @solution , $numbers[$pos + 1] ) ;
   }
   $pos += 2 ;
}
say "(" . join( ',' , @solution) . ")" ;
