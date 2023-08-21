#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub decompose {
   my $number = shift ;
   my @digits ;
   while ( $number != 0 ) {
      push @digits , $number % 10 ;
      $number = int( $number / 10 ) ;
   }
   return reverse @digits ;
}

say "Enter some positive integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @allDigits ;
my @numbers = split( /\s/ , $line ) ;
for my $num ( @numbers ) {
   my @digits = decompose( $num ) ;
   map { push @allDigits , $_ } @digits ;
}
say '(' . join( ',' , @allDigits ) . ')' ;

