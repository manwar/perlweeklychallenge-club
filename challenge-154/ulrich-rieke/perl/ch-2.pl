#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

sub isPrime {
  my $number = shift ;
  if ( $number == 1 ) {
      return 0 ;
  }
  elsif ( $number == 2 ) {
      return 1 ;
  }
  else {
      my $root = ceil( sqrt( $number ) ) ;
      for my $i ( 2 .. $root ) {
    if ( $number % $i == 0 ) {
        return 0 ;
    }
      }
      return 1 ;
  }
}

my @padovans = ( 1 , 1 , 1 ) ;
my @padovanPrimes ;
my %inserted ;
while ( scalar( @padovanPrimes != 10 ) ) {
  push @padovans , $padovans[0] + $padovans[1] ;
  my $last = $padovans[ -1 ] ;
  if ( isPrime( $last )) {
      if ( not exists( $inserted{ $last } )) {
    push @padovanPrimes , $last ;
      }
      $inserted{$last}++ ;
  }
  shift @padovans ;
}
map {print "$_ "} @padovanPrimes ;
say " " ;
