#!/usr/bin/perl ;
use strict ;
use warnings ;
use Algorithm::Combinatorics qw ( combinations ) ;
use POSIX ;
use feature 'say' ;

sub isPentagonNumber {
  my $num = shift ;
  my $root = ( sqrt( 24 * $num + 1 ) + 1 ) / 6 ;
  return floor( $root ) == $root ;
}

sub toPentagon {
  my $num = shift ;
  return ( $num * ( 3 * $num  - 1 )) / 2 ;
}

my @pentagons = (1, 5, 12, 22, 35, 51, 70, 92, 117 , 145 ) ;
my $current = 10 ;
my $iter = combinations( \@pentagons, 2 ) ;
while ( my $c = $iter->next ) {
  if ( isPentagonNumber( $c->[ 0 ] + $c->[1] ) &&
    isPentagonNumber( abs( $c->[0] - $c->[1] ) ) ) {
      say "$c->[0] , $c->[1]" ;
      exit( 0 ) ;
  }
}
my $combiFound = 0 ;
my @pair ;
do {
  $current++ ;
  push @pentagons , toPentagon( $current ) ;
  for my $i (@pentagons[0 .. $current - 2]) {
      if ( isPentagonNumber( $i + $pentagons[ -1 ] ) &&
          isPentagonNumber( abs( $i - $pentagons[ -1 ] ) ) ) {
    push @pair , $i , $pentagons[ -1 ] ;
    $combiFound = 1 ;
    last ;
    }
  }
} while ( $combiFound == 0 ) ;
say join( ", " , @pair ) ;
