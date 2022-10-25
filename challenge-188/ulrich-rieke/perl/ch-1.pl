#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a number of positive integers, separated by a blank!" ;
say "Enter another positive integer as divisors as last number!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $k = $numbers[-1] ;
my $count = 0 ;
my $len = scalar( @numbers ) ;
for my $i ( 0 .. $len - 3 ) {
  for my $j ( $i + 1 .. $len - 2 ) {
      if (( $numbers[ $i ] + $numbers[ $j ] ) % $k == 0 ) {
    $count++ ;
      }
  }
}
say $count ;
