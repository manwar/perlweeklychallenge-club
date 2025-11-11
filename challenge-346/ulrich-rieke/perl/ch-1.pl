#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

sub findLength {
   my $word = shift ;
   my $current = shift ;
   my @balances ;
   my $balance = 1 ;
   push( @balances , $balance ) ;
   my $len = length $word ;
   $current++ ;
   while ( $current < $len ) {
      if ( substr( $word , $current , 1 ) eq "(" ) {
	 $balance++ ;
      }
      else {
	 $balance-- ;
      }
      if ( $balance < 0 ) {
	 last ;
      }
      push( @balances , $balance ) ;
      $current++ ;
   }
   my $howmany = scalar( grep { $_ == 0 } @balances ) ;
   my $result ;
   if ( $howmany == 0 ) {
      $result = 0 ;
   }
   elsif ( $howmany == 1 ) {
      my $pos = 0 ;
      while ( $balances[$pos] != 0 ) {
	 $pos++ ;
      }
      $result = $pos + 1 ;
   }
   else {
      my $pos = scalar( @balances ) - 1 ;
      while ( $balances[$pos] != 0 ) {
	 $pos-- ;
      }
      $result = $pos + 1 ;
   }
   return $result ;
}

say "Enter a string consisting of parentheses only!" ;
my $word = <STDIN> ;
chomp $word ;
my $len = length $word ;
my @lengths ;
for my $pos (0..$len - 2) {
   if ( substr( $word , $pos , 1 ) eq "(" ) {
      push( @lengths , findLength( $word , $pos )) ;
   }
}
say max( @lengths ) ;
