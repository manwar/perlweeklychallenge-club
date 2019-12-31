#!/usr/bin/perl ;
use strict ;
use warnings ;

sub isPrime {
  my $number = shift ;
  if ( $number == 1 ) {
      return 0 ;
  }
  if ( $number == 2 ) {
      return 1 ;
  }
  for ( my $i = 2 ; $i < int ( $number / 2 + 1 ) ; $i++ ) {
      if ( $number % $i == 0 ) {
    return 0 ;
    last ;
      }
  }
  return 1 ;
}

sub isAttractive {
  my $number = shift ;
  my @primeFactors = primeFactors( $number ) ;
  return isPrime( scalar @primeFactors ) ;
}

sub primeFactors {
  my $num = shift ;
  if ( $num == 1 ) {
      return ( ) ;
  }
  my $current = 2 ;
  my @primeFactors ;
  while ( $num != 1 ) {
      if ( $num % $current == 0 ) {
    push @primeFactors , $current ;
    $num /= $current ;
      }
      else {
    do {
        $current++ ;
    } while ( not isPrime( $current ) ) ;
      }
  }
  return @primeFactors ;
}

my @attractives = grep { isAttractive( $_ ) } (1..50) ;
foreach my $num ( @attractives ) {
  print "$num " ;
}
print "\n" ;
