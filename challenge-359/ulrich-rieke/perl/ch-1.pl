#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ; 

sub findPair {
   my $number = shift ;
   if ( $number < 10 ) {
      return (0 , $number ) ;
   }
   else {
      my $root = $number ;
      my $persistence = 0 ;
      while ( $root > 9 ) {
         my @digits ;
         while ( $root != 0 ) {
            push( @digits , $root % 10 ) ;
            $root = int( $root / 10 ) ;
         }
         $persistence++ ;
         $root = sum( @digits ) ;
      }
      return ( $persistence , $root ) ;
   }
}

say "Enter a positive integer!" ;
my $number = <STDIN> ;
chomp $number ;
my @result = findPair( $number ) ;
say "Persistence  = " . $result[0] ;
say "Digital root = " . $result[1] ;

