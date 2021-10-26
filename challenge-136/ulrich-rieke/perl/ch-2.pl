#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( combinations ) ;
use List::Util qw ( sum ) ;

my $n = $ARGV[ 0 ] ;
if (  $n == 1 || $n == 2 ) {
  say 1 ;
  exit( 0 ) ;
}
else {
  my @fibonacci = (1 , 2 ) ;
  my %fibonums ;
  while ( $fibonacci[ -1 ] + $fibonacci[ -2 ] < $n ) {
      push ( @fibonacci , $fibonacci[ -1 ] + $fibonacci[ - 2 ] ) ;
  }
  map { $fibonums{$_}++ } @fibonacci ;
  my $sequencesFound = 0 ;
  for my $i ( 2 .. scalar( @fibonacci ) - 1 ) {
      my $iter = combinations( \@fibonacci , $i ) ;
      while ( my $c = $iter->next ) {
    if ( sum( @{$c} ) == $n ) {
        $sequencesFound++ ;
    }
      }
  }
  if ( exists ( $fibonums{ $n } ) ) {
      $sequencesFound++ ;
  }
  say $sequencesFound ;
}
