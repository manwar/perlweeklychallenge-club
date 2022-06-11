#!/usr/bin/perl ;
use strict ;
use feature 'say' ;
use warnings ;
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

sub isPalindrome {
  my $number = shift ;
  my @digits = split( // , $number ) ;
  return join( '' , reverse @digits ) eq $number ;
}

say join( ',' , grep { isPrime( $_ ) && isPalindrome( $_ ) } (2 .. 999)) ;
