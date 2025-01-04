#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my @partial_sums ;
my $current = $numbers[0] + $numbers[1] ;
push( @partial_sums , $current ) ;
if ( $len > 2 ) {
   for my $i (2..$len - 1 ) {
      $current += $numbers[ $i ] ;
      push( @partial_sums , $current ) ;
   }
}
my $mini = min( @partial_sums ) ;
my $result = 1 - $mini ;
if ( $result <= 0 ) {
   say 1 ;
}
else {
   say $result ;
}
