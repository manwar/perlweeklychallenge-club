#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;
use Algorithm::Combinatorics qw( combinations ) ;

sub findProperDivisors {
  my $number = shift ;
  my @divisors = ( 1 ) ;
  for my $i ( 2 .. int( $number / 2 ) + 1 ) {
      if ( $number % $i == 0 ) {
    push @divisors , $i ;
      }
  }
  return @divisors ;
}

my $n = $ARGV[0] ;
my $isWeird = 1 ;
my @divisors = findProperDivisors( $n ) ;
if ( sum( @divisors ) <= $n ) {
  $isWeird = 0 ;
}
else {
  for my $i ( 2 .. scalar( @divisors ) - 1 ) {
      my $iter = combinations( \@divisors , $i ) ;
      while ( my $c = $iter->next ) {
    if ( sum( @$c ) == $n ) {
        $isWeird = 0 ;
    }
      }
  }
}
if ( $isWeird == 1 ) {
  say 1 ;
}
else {
  say 0 ;
}
