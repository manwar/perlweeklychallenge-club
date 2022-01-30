#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( sum ) ;

sub find {
  my $num = shift ;
  my $fibos = shift ;
  for my $fibonum( @$fibos ) {
      if ( $num == $fibonum ) {
    return 1 ;
      }
  }
  return 0 ;
}

my @fibonaccis = (0 , 1 ) ;
while ( scalar( @fibonaccis ) < 8 ) {
  push @fibonaccis , $fibonaccis[-1] + $fibonaccis[-2] ;
}
my $N = $ARGV[0] ;
my @fiboDigitSums ;
my $current = -1 ;
my $sumOfDigits ;
while ( scalar( @fiboDigitSums ) < $N ) {
  $current++ ;
  $sumOfDigits = sum( split( // , $current ) ) ;
  if ( find( $sumOfDigits , \@fibonaccis ) ) {
      push @fiboDigitSums, $current ;
  }
  if ( $sumOfDigits > $fibonaccis[-1] ) {
      do {
    push @fibonaccis, $fibonaccis[-1] + $fibonaccis[-2] ;
      } while ( $sumOfDigits > $fibonaccis[-1] ) ;
  }
}
say join( ',' , @fiboDigitSums ) ;
