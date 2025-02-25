#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;
say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { $a <=> $b } @numbers ;
my $len = scalar( @sorted ) ;
my $run = 1 ;
my @lengths ;
my $i = 1 ;
while ( $i < $len ) {
   if ( $sorted[ $i ] - $sorted[ $i - 1 ] == 1 ) {
      $run++ ;
   }
   else {
      push( @lengths , $run ) ;
      $run = 1 ;
   }
   $i++ ;
}
push( @lengths , $run ) ;
my $maximum = max( @lengths ) ;
if ( $maximum == 1 ) {
   say -1 ;
}
else {
   say $maximum ;
}
