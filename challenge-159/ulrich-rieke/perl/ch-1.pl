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

sub myOrder { ($a->[0] / $a->[1]) <=> ($b->[0] / $b->[1] ) }

sub isCoprime {
  my $numbera = shift ;
  my $numberb = shift ;
  my @firstPrimes = primeDecomposition( $numbera ) ;
  my @secondPrimes = primeDecomposition( $numberb ) ;
  my %firstFactors ;
  for my $n ( @firstPrimes ) {
      $firstFactors{$n}++ ;
  }
  my %secondFactors ;
  for my $n ( @secondPrimes ) {
      $secondFactors{$n}++ ;
  }
  my @common ;
  for my $n ( keys %firstFactors ) {
      if ( exists( $secondFactors{$n} ) ) {
    push @common , $n ;
      }
  }
  if ( scalar( @common ) == 0 ) {
      return 1 ;
  }
  else {
      return 0 ;
  }
}

my $n = $ARGV[0] ;
while ( $n <= 0 ) {
  say "enter a number greater than 0! Re-enter!" ;
  $n = <STDIN> ;
  chomp $n ;
}
#find all coprime pairs of numerators and denominators between 1 and n - 1
#and n respectively and order them in ascending order
my @pairs ;
push @pairs , [0 , 1] ;
for my $num (1 .. $n - 1) {
  for my $denom( 0 .. $n ) {
      if ( ($num < $denom ) && isCoprime( $num , $denom ) ) {
    push @pairs , [$num , $denom] ;
      }
  }
}
my @sorted = sort myOrder @pairs ;
for my $p ( @sorted ) {
  print "$p->[0]/$p->[1], " ;
}
say "1/1" ;
