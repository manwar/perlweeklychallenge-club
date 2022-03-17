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

sub toBinary {
  my $num = shift ;
  my @nums ;
  while ( $num != 0 ) {
      my $remainder = $num % 2 ;
      push @nums, $remainder ;
      $num = floor ( $num / 2 ) ;
  }
  return reverse @nums ;
}

sub isPernicious {
  my $number = shift ;
  my @binary = toBinary( $number ) ;
  return isPrime( scalar( grep { $_ == 1 } @binary ) ) ;
}

my @perniciousNumbers ;
my $current = 0 ;
while ( scalar( @perniciousNumbers ) != 10 ) {
  $current++ ;
  if ( isPernicious( $current ) ) {
      push @perniciousNumbers, $current ;
  }
}
say join( ',' , @perniciousNumbers ) ;
