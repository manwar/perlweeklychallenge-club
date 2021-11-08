#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findDivisors {
  my $num = shift ;
  my @divisors ;
  for my $n ( 1 .. $num ) {
      if ( ($num % $n ) == 0 ) {
    push @divisors , $n ;
      }
  }
  return @divisors ;
}

sub isPrime {
  my $num = shift ;
  if ( $num == 1 ) {
      return 0 ;
  }
  my @divisors = findDivisors( $num ) ;
  if ( ($divisors[0] == 1) && ($divisors[1] == $num) ) {
      return 1 ;
  }
  else {
      return 0 ;
  }
}

sub isComposite {
  my $number = shift ;
  if ( (not ( isPrime( $number ) )) && ( $number != 1 ) ) {
      return 1 ;
  }
  else {
      return 0 ;
  }
}

sub prime_factorialize {
  my $number = shift ;
  my @primenumbers ;
  my $current = 2 ;
  while ( $number != 1 ) {
      if ( ($number % $current) == 0 ) {
    $number /= $current ;
    push @primenumbers, $current ;
      }
      else {
    do {
        $current++ ;
    } while ( not ( isPrime( $current ) ) ) ;
      }
  }
  return @primenumbers ;
}

sub toDigitSum {
  my $number = shift ;
  if ( $number < 10 ) {
      return $number ;
  }
  else {
      my $sum = 0 ;
      map { $sum += $_ } split( // , $number ) ;
      return $sum ;
  }
}

sub isSmithNumber {
  my $num = shift ;
  my $digitsum = toDigitSum( $num ) ;
  my @primefactors = prime_factorialize( $num ) ;
  my %factorCount ;
  map { $factorCount{$_}++ } @primefactors ;
  my $factorSum = 0 ;
  for my $key ( keys %factorCount ) {
      $factorSum += ( toDigitSum( $key ) * $factorCount{ $key } ) ;
  }
  if ( $factorSum == $digitsum ) {
      return 1 ;
  }
  else {
      return 0 ;
  }
}

my @smithNumbers ;
my $current = 0 ;
while ( scalar( @smithNumbers ) < 10 ) {
  $current++ ;
  if ( ( isComposite( $current )) && ( isSmithNumber( $current ) ) ) {
      push @smithNumbers, $current ;
  }
}
say join( ", " , @smithNumbers ) ;
