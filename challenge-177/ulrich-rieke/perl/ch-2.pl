#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

sub isPrime {
  my $number = shift ;
  if ( $number == 1 || $number == 0 ) {
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

sub isPrimeCyclops {
  my $number = shift ;
  my $zeroes = $number =~ tr/0/0/ ;
  return isPrime( $number ) && ( $number eq reverse( $number ) )
      && ( $zeroes == 1 ) && (substr( $number , int( (length $number) / 2 ) , 1 )
      eq '0' ) ;
}

my @prime_cyclopses ;
my $current = 100 ;
while ( scalar( @prime_cyclopses ) != 20 ) {
  if ( isPrimeCyclops( $current ) ) {
      push @prime_cyclopses , $current ;
  }
  $current++ ;
  if ( (length $current) % 2 == 0 ) { #we only admit an odd number of digits
      $current *= 10 ;
  }
}
say join( ',' , @prime_cyclopses ) ;
