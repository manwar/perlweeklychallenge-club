#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub fibonacci {
   my $number = shift ;
   if ( $number == 0 || $number == 1 ) {
      return $number ;
   }
   if ( $number > 1 ) {
      return fibonacci( $number - 2 ) + fibonacci( $number - 1 ) ;
   }
}

sub findFirst {
   my $fibos = shift ;
   my $number = shift ;
   my $pos = 0 ;
   while ( $fibos->[$pos] > $number ) {
      $pos++ ;
   }
   return $fibos->[$pos] ;
}

say "Enter a number smaller than or equal to 100!" ;
my $number = <STDIN> ;
chomp $number ;
my @fibonaccis ;
for my $num( 0..12 ) {
   push( @fibonaccis, fibonacci( $num ) ) ;
}
@fibonaccis = reverse( @fibonaccis ) ;
my @result ;
while ( $number != 0 ) {
   my $found = findFirst( \@fibonaccis, $number ) ;
   push( @result , $found ) ;
   $number -= $found ;
}
say join( ',' , @result ) ;
