#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub primeDecomposition {
  my $number = shift ;
  my @primes ;
  my $current = 2 ;
  do {
      if ( $number % $current == 0 ) {
    push @primes , $current ;
        $number /= $current ;
      }
      else {
    $current++ ;
      }
  } until ( $number == 1 ) ;
  return @primes ;
}

my $n = $ARGV[0] ;
while ( $n <= 0 ) {
  say "Only positive integers are allowed!" ;
  $n = <STDIN> ;
  chomp $n ;
}
my %primeFactors ;
my @primes = primeDecomposition( $n ) ;
for my $p ( @primes ) {
  $primeFactors{$p}++ ;
}
my $primesLen = scalar( @primes ) ;
my $factorLen = scalar( keys %primeFactors ) ;
if ( $primesLen == $factorLen ) { #square-free
  if ( $primesLen % 2 == 0 ) {
      say 1 ;
  }
  else {
      say -1 ;
  }
}
else {
  say 0 ;
}
