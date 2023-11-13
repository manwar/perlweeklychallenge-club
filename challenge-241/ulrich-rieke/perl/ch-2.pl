#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#the smallest divisor always is a prime number. So we have to keep
#finding the smallest divisors.

sub findSmallest {
   my $number = shift ;
   my $divisor = 2 ;
   while ( $number % $divisor != 0 ) {
      $divisor++ ;
   }
   return $divisor ;
}

sub findPrimeFactors {
   my $number = shift ;
   my @primeFactors ;
   while ( $number != 1 ) {
      my $divisor = findSmallest( $number ) ;
      push @primeFactors , $divisor ;
      $number /= $divisor ;
   }
   return @primeFactors ;
}

say "Enter some unique positive integers greater than 2" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { scalar( findPrimeFactors( $a ) ) <=> 
   scalar( findPrimeFactors( $b ) ) || $a <=> $b } @numbers ;
say "(" . join( ',' , @sorted ) . ")" ;
