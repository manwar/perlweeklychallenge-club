#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all none ) ;
use POSIX ;

sub createCycle {
  my $num = shift ;
  my @cycle ;
  push @cycle , $num ;
  my $rotated = substr( $num , 1 ) . substr( $num , 0 , 1 ) ;
  while ( $rotated ne $num ) {
      push @cycle , $rotated ;
      $rotated = substr( $rotated , 1 ) . substr( $rotated , 0 , 1 ) ;
  }
  return @cycle ;
}

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

my @circularPrimes ;
my %circularsSeen ;
my $current = 100 ;
while ( scalar( @circularPrimes ) != 10 ) {
  if ( $current !~ /0/ ) {
      my @cycle = createCycle( $current ) ;
      if ( (all { isPrime( $_ ) } @cycle) && (none { $circularsSeen{ $_ } } @cycle )) {
    push @circularPrimes , $current ;
    map { $circularsSeen{ $_ }++ } @cycle ;
      }
  }
  $current++ ;
}
say join( ', ' , @circularPrimes ) ;
