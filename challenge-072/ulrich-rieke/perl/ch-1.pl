#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub faculty {
  my $n = shift ;
  my $product = 1 ;
  map { $product *= $_ } (1..$n) ;
  return $product ;
}

my $N = $ARGV[ 0 ] ;
my @digits = reverse split (// , faculty( $N ) ) ;
my $zeroes = 0 ;
while ( shift @digits == 0 ) {
  $zeroes++ ;
}
say $zeroes ;
