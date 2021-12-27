#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $m = $ARGV[ 0 ] ;
my $n = $ARGV[ 1 ] ;
my @divisors ;
for my $i (1 .. $m ) {
  if ( $m % $i == 0 ) {
      push @divisors , $i ;
  }
}
my $output = 0 ;
for my $num ( @divisors ) {
  if ( $num % 10 == $n ) {
      $output++ ;
  }
}
say $output ;
