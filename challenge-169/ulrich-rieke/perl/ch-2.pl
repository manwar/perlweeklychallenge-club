#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min max reduce ) ;

sub primeDecompose {
  my $number = shift ;
  my $current = 2 ;
  my @primeFactors ;
  while ( $number != 1 ) {
      if ( $number % $current == 0 ) {
    push @primeFactors, $current ;
    $number /= $current ;
      }
      else {
    $current++ ;
      }
  }
  return @primeFactors ;
}

sub gcd {
  my $first = shift ;
  my $second = shift ;
  my %firstDivisors ;
  my %secondDivisors ;
  for my $n ( 1 .. $first ) {
      if ( $first % $n == 0 ) {
    $firstDivisors{ $n }++ ;
      }
  }
  for my $n ( 1 .. $second ) {
      if ( $second % $n == 0 ) {
    $secondDivisors{ $n }++ ;
      }
  }
  my @common = grep { exists ($secondDivisors{$_}) } keys %firstDivisors ;
  return max( @common ) ;
}

sub isAchilles {
  my $number = shift ;
  my @primeFactors = primeDecompose( $number ) ;
  my %achilles ;
  for my $n ( @primeFactors ) {
      $achilles{$n}++ ;
  }
  my @frequencies = values( %achilles ) ;
  my $minFactor = min( @frequencies ) ;
  if ( $minFactor < 2 ) {
      return 0 ;
  }
  else {
      return ( (reduce { gcd( $a , $b ) } @frequencies) == 1 ) ;
  }
}

my @achillesNumbers ;
my $current = 2 ;
while ( scalar( @achillesNumbers ) != 20 ) {
  if ( isAchilles( $current ) ) {
      push @achillesNumbers , $current ;
  }
  $current++ ;
}
say join( ',' , @achillesNumbers ) ;
