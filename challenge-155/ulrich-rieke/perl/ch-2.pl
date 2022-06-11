#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub count {
  my $element = shift ;
  my $array = shift ;
  return scalar( grep { $_ == $element } @$array ) ;
}

my @fibonaccis = (0 , 1 ) ;
while ( scalar( @fibonaccis ) != 500 ) {
  push @fibonaccis , $fibonaccis[-1] + $fibonaccis[-2] ;
}
#I take the first 2 identical array slices as representatives for
#the entire range of Pisano numbers, without proving whether this is
#correct
my @thirdPisanos = map { $_ % 3 } @fibonaccis ;
my @differences ;
my $n = 2 ;
push @differences , $thirdPisanos[0] - $thirdPisanos[2] ;
push @differences , $thirdPisanos[1] - $thirdPisanos[3] ;
while ( count( 0 , \@differences ) != $n ) {
  $n++ ;
  @differences = ( ) ;
  for my $i (0 .. $n - 1 ) {
      push @differences, $thirdPisanos[ $i ] - $thirdPisanos[ $i + $n ] ;
  }
}
say $n ;
