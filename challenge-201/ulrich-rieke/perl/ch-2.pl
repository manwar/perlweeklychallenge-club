#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations_with_repetition ) ;
use List::Util qw ( sum ) ;

my $number = $ARGV[0] ;
my $heapSum = 2 ;#$number times 1 and 1 times $number pennies are already there
my @numbers = (1..$number) ;
for my $num ( 2..$number - 1 ) {
  my $iter = combinations_with_repetition(\@numbers , $num ) ;
  while ( my $p = $iter->next ) {
      if ( sum( @$p ) == $number ) {
    $heapSum++ ;
      }
  }
}
say $heapSum ;
