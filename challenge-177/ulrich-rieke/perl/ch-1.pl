#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $number = $ARGV[0] ;
my @damm_table = ( [0,  3 , 1 , 7 , 5 , 9 , 8 , 6 , 4 , 2 ] ,
          [7 , 0 , 9 , 2 , 1 , 5 , 4 , 8 , 6 , 3 ] ,
          [4 , 2 , 0 , 6 , 8 , 7 , 1 , 3 , 5 , 9 ] ,
          [1 , 7 , 5 , 0 , 9 , 8 , 3 , 4 , 2 , 6 ] ,
          [6 , 1 , 2 , 3 , 0 , 4 , 5 , 9 , 7 , 8 ] ,
          [3 , 6 , 7 , 4 , 2 , 0 , 9 , 5 , 8 , 1 ] ,
          [5 , 8 , 6 , 9 , 7 , 2 , 0 , 1 , 3 , 4 ] ,
          [8 , 9 , 4 , 5 , 3 , 6 , 2 , 0 , 1 , 7 ] ,
          [9 , 4 , 3 , 8 , 6 , 1 , 7 , 2 , 0 , 5 ] ,
          [2 , 5 , 8 , 1 , 4 , 3 , 6 , 7 , 9 , 0 ] ) ;
my @digits = split( // , $number ) ;
my $len = length $number ;
my $interim_digit = 0 ;
#walk through all the digits of the input number, taking the $interim_digit
#as row and the digit as column, look it up in the Damm table and replace
#$interim_digit with that value
for my $num ( 0 .. $len - 2 ) {
  $interim_digit = $damm_table[ $interim_digit ]->[$digits[ $num ]] ;
}
#if the $interim_digit found so far is equal to the last digit it's a valid number
if ( $interim_digit == $digits[-1] ) {
  say 1 ;
}
else {
  say 0 ;
}
