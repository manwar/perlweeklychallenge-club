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

sub isLeftTruncatablePrime {
  my $number = shift ;
  if ( $number =~ /0/ ) {
      return 0 ;
  }
  my $len = length( $number ) ;
  for my $i( 0 .. $len - 1 ) {
      my $truncated = substr( $number , $i ) + 0 ; #enforce number evaluation
      if ( not isPrime( $truncated ) ) {
    return 0 ;
      }
  }
  return 1 ;
}

my @truncatables ;
my $current = 0 ;
while ( scalar( @truncatables) < 20 ) {
      $current++ ;
      if ( isLeftTruncatablePrime( $current ) ) {
    push @truncatables , $current ;
      }
}
say join( ',' , @truncatables ) ;
