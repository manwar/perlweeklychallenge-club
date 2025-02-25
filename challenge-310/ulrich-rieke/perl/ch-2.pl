#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my @evens ;
my @odds ;
for my $pos (0..$len - 1 ) {
   if ( $pos % 2 == 0 ) {
      push( @evens , $numbers[$pos] ) ;
   }
   else {
      push( @odds, $numbers[$pos] ) ;
   }
}
my @sortedEvens = sort { $a <=> $b } @evens ;
my @sortedOdds = sort { $b <=> $a } @odds ;
my @merged ;
for my $pos (0..$len - 1 ) {
   my $number ;
   if ( $pos % 2 == 0 ) {
      $number = shift( @sortedEvens ) ;
   }
   else {
      $number = shift ( @sortedOdds ) ;
   }
   push( @merged , $number ) ;
}
say '(' . join( ',' , @merged ) . ')' ;
