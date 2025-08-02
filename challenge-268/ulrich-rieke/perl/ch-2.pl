#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an even number of integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split ( /\s+/ , $line ) ;
my @sorted = sort { $a <=> $b } @numbers ;
my @target ;
while ( @sorted ) {
   my ( $smallest , $secsmallest ) = splice( @sorted , 0 , 2 ) ;
   push( @target , $secsmallest , $smallest ) ;
   @sorted = sort { $a <=> $b } @sorted ;
}
say "(" . join( ',' , @target ) . ")" ;
