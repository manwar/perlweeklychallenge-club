#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

sub toReverseBinary {
   my $number = shift ;
   my @array ;
   while ( $number != 0 ) {
      push( @array , $number % 2 ) ;
      $number = floor( $number / 2 ) ;
   }
   return @array ;
}

sub toNumber {
   my $array = shift ;
   my $total ;
   my $multiplier = 2 ** ( scalar( @$array ) - 1 ) ;
   for my $num( @$array ) {
      $total += $num * $multiplier ;
      $multiplier /= 2 ;
   }
   return $total ;
}

sub convert {
   my $number = shift ;
   my @reverseBinary = toReverseBinary( $number ) ;
   my $reflected = toNumber( \@reverseBinary ) ;
   return $reflected ;
}

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp  $line ;
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { convert( $a ) <=> convert( $b ) || $a <=> $b }
 @numbers ;
say '(' . join( ',' , @sorted ) . ')' ; 
