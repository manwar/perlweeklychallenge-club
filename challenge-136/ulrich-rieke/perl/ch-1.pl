#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( max ) ;
use POSIX ;

sub log2 {
  my $number = shift ;
  return log( $number ) / log( 2 ) ;
}

sub gcd {
  my $firstNumber = shift ;
  my $secondNumber = shift ;
  my %divisors ;
  for my $i ( 1 .. $firstNumber ) {
      if ( $firstNumber % $i == 0 ) {
    $divisors{ $i }++ ;
      }
  }
  for my $i ( 1 .. $secondNumber ) {
      if ( $secondNumber % $i == 0 ) {
    $divisors{ $i }++ ;
      }
  }
  return max ( grep { $divisors{ $_ } == 2 } keys %divisors ) ;
}

my $m = $ARGV[ 0 ] ;
my $n = $ARGV[ 1 ] ;
my $theLog = log2( gcd( $m , $n ) ) ;
if ( floor( $theLog ) == $theLog ) {
  say 1 ;
}
else {
  say 0 ;
}
