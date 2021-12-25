#!/usr/bin/perl ;
use strict ;
use warnings ;
use Algorithm::Combinatorics qw ( combinations ) ;
use POSIX ;
use feature 'say' ;

sub isPrime {
  my $number = shift ;
  if ( $number == 2 ) {
      return 1 ;
  }
  else {
      my $limit = floor(sqrt( $number )) + 1 ;
      my $current = 2 ;
      while ( $current < $limit ) {
    if ( $number % $current == 0 ) {
        return 0 ;
    }
    $current++ ;
      }
  }
  return 1 ;
}

my @primes = grep { isPrime( $_ )} (2 .. 100 ) ;
my @products ;
my $iter = combinations( \@primes , 2 ) ;
while ( my $c = $iter->next ) {
  push @products , $c->[0] * $c->[1] ;
}
my @smallPrimes = grep { $_ < 12 } @primes ;
for my $num ( @smallPrimes ) {
  push @products , $num * $num ;
}
my @sorted = sort { $a <=> $b } @products ;
say join( ',' , grep { $_ <= 100 } @sorted ) ;
