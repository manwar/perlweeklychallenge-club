#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any sum ) ;
use POSIX ;
#we convert a number into the digits corresponding to the given base
#if any digit is greater than 9 we must disregard it, that number 
#cannot be an Armstrong number
sub isArmstrong {
   my $number = shift ;
   my $base = shift ;
   my @digits ;
   my $comparison = $number ;
   while ( $number != 0 ) {
      push( @digits , $number % $base ) ;
      $number = floor( $number / $base ) ;
   }
   if ( any { $_ > 9 } @digits ) {
      return 0 ;
   }
   else {
      my $len = scalar( @digits ) ;
      my @converted = map { $_ ** $len } @digits ;
      if ( (sum @converted)  == $comparison ) {
         return 1 ;
      }
      else {
         return 0 ;
      }
   }
}

say "Enter , separated by space , a base and a limit!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $base , $limit ) = split( /\s/ , $line ) ;
#by definition, all numbers from 0 to $base - 1 are part of the solution!
my @solution ;
for my $n( 0..$base - 1 ) {
   push( @solution , $n ) ;
}
for my $n( $base..$limit - 1) {
   if ( isArmstrong( $n, $base )) {
      push( @solution , $n ) ;
   }
}
say '(' . join( ',' , @solution ) . ')' ;
