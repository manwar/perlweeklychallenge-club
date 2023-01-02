#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

sub isPrime {
  my $number = shift ;
  if ( $number < 2 ) {
      return 0 ;
  }
  my $stop = sqrt( $number ) ;
  for my $i ( 2 .. floor( $stop )) {
      if ( $number % $i == 0 ) {
        return 0 ;
      }
  }
  return 1 ;
}

my $number = $ARGV[0] ;
say scalar( grep { isPrime( $_ ) } (0..$number - 1 ) ) ;
