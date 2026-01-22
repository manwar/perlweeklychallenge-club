#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max uniqstr ) ;

sub reduce {
   my $numerator = shift ;
   my $denominator = shift ;
   my %firstdivisors ; #divisors of numerator
   my %seconddivisors ; #divisors of denominator
   for my $n( 1..$numerator ) {
      if ( $numerator % $n == 0 ) {
         $firstdivisors{$n}++ ;
      }
   }
   for my $n( 1..$denominator ) {
      if ( $denominator % $n == 0 ) {
         $seconddivisors{$n}++ ;
      }
   }
   my @common = grep { exists( $seconddivisors{$_} ) } keys %firstdivisors ;
   my $gcd = max( @common ) ;
   if ( $gcd == 1 ) {
      return ( $numerator , $denominator ) ;
   }
   else {
      return ( $numerator / $gcd , $denominator / $gcd ) ;
   }
}

say "Enter a positive integer!" ;
my $number = <STDIN> ;
chomp $number ;
my @fractions ; #contains arrays of the division of $numerator and $denominator
# and $numerator and $denominator themselves
for my $num( 1..$number ) {
   for my $denom ( 1..$number ) {
      push( @fractions , [$num / $denom , $num , $denom] ) ;
   }
}
@fractions = sort { $a->[0] <=> $b->[0] } @fractions ;
my @converted ; #gets the reduced fractions 
for my $subarray( @fractions ) {
   my @reduced = reduce( $subarray->[1] , $subarray->[2] ) ;
   push( @converted , [@reduced] ) ;
}
my @output = map { $_->[0] . "/" . $_->[1] } @converted ;
@output = uniqstr( @output ) ;
say join( ", " , @output ) ;
