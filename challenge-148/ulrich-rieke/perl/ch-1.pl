#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my @less_than_ten = ( "one" , "two" , "three" , "four" , "five" , "six" , "seven" ,
      "eight" , "nine" ) ;
my @teens = ("ten" , "twenty" , "thirty" , "forty" , "fifty" , "sixty" , "seventy" ,
      "eighty" , "ninety" , "hundred" ) ;
my @ebanNumbers ;
for my $i (0 .. scalar( @less_than_ten ) - 1 ) {
  if ( $less_than_ten[ $i ] !~ /e/ ) {
      push @ebanNumbers , $i + 1 ;
  }
}
for my $i (0 .. scalar( @teens ) - 1 ) {
  if ( $teens[ $i ] =~ /e/ ) {
      next ;
  }
  else {
      push @ebanNumbers , ( $i + 1 ) * 10 ;
      for my $j (0 .. scalar( @less_than_ten ) - 1 ) {
    if ( $less_than_ten[ $j ] !~ /e/ ) {
        push @ebanNumbers , ( $i + 1 ) * 10 + ( $j + 1 ) ;
    }
      }
  }
}
say join( ',' , @ebanNumbers ) ;
