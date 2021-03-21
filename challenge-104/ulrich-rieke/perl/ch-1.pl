#!/usr/bin/perl ;
use strict ;
use warnings ;

my @fusc ;
push (@fusc , 0 , 1 ) ;
for my $n (2 .. 49 ) {
  if ( $n % 2 == 0 ) {
      $fusc[ $n ] = $fusc[ $n / 2 ] ;
  }
  else {
      my $half = int( $n / 2 ) ;
      $fusc[ $n ] = $fusc[ $half ] + $fusc[ $half + 1 ] ;
  }
}
map { print "$_ "} @fusc ;
print "\n" ;
