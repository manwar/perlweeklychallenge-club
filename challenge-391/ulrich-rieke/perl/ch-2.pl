#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an even number of positive integers!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my $pos = 0 ;
my @pairs ;
while ( $pos < $len - 1 ) {
   my $p = [$numbers[$pos] , $numbers[$pos + 1]] ;
   push( @pairs , $p ) ;
   $pos += 2 ;
}
my @selected ;
my @sorted = sort { $a->[0] <=> $b->[0] } @pairs ;
push( @selected , $sorted[0] ) ;
for my $i (1..scalar( @sorted) - 1) {
   if ( ($sorted[$i]->[0] > $selected[-1]->[0])  &&
       ($sorted[$i]->[1] > $selected[-1]->[1]) ) {
         push( @selected , $sorted[$i] ) ;
   }
}
say scalar( @selected ) ;
