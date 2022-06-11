#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;
use List::Util qw ( product ) ;

sub isPrime {
  my $number = shift ;
  my $stop = sqrt( $number ) ;
  for my $i ( 2 .. floor( $stop )) {
      if ( $number % $i == 0 ) {
        return 0 ;
      }
  }
  return 1 ;
}

my @primeNumbers ;
my $n = 2 ;
while ( scalar( @primeNumbers) != 11 ) {
  if ( isPrime( $n ) ) {
      push @primeNumbers, $n ;
  }
  $n++ ;
}
my @primorials ;
push @primorials, 2 ;
for my $i ( 1 .. 10 ) {
  push @primorials, product( @primeNumbers[0 .. $i] ) ;
}
my %fortunates ;
my $current = 0 ;
while ( scalar ( keys %fortunates ) != 8 ) {
  my $num = $primorials[ $current ] ;
  my $m = 2 ;
  my $sum = $num + $m ;
  while ( not isPrime( $sum ) ) {
      $m++ ;
      $sum = $num + $m ;
  }
  $current++ ;
  $fortunates{ $m }++ ;
}
say join( ',' , sort { $a <=> $b } keys %fortunates ) ;
