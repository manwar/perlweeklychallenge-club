#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#prime decomposition is dividing a number by its smallest current divisor
#which, for obvious mathematical reasons, must be a prime number
sub findFactors {
   my $number = shift ;
   my $mode = shift ;
   my @primefactors ;
   my $divisor = 2 ;
   while ( $number != 1 ) {
      if ( $number % $divisor == 0 ) {
         push( @primefactors , $divisor ) ;
         $number /= $divisor ;
      }
      else {
         $divisor++ ;
      }
   }
   if ( $mode ) {
      return scalar( @primefactors ) ;
   }
   else {
      my %factors ;
      map { $factors{$_}++ } @primefactors ;
      return scalar( keys( %factors ) ) ;
   }
}

say "Enter a number!" ;
my $number = <STDIN> ;
chomp $number ;
say "Enter a mode ( 0 or 1 )!" ;
my $mode = <STDIN> ;
chomp $mode ;
say findFactors( $number , $mode ) ;
