#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;

sub findSum {
  my $array = shift ;
  my $sum = 0 ;
  map { $sum += $_ } @$array ;
  return $sum ;
}

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

my $N = $ARGV[0] ;
my $line ;
if ( isPrime ( $N ) ) {
  $line = "1 , $N is a prime number!" ;
}
else {
  my @primes = grep { isPrime( $_ ) } (2..$N) ;
  my $len = scalar @primes ;
  my $elements = 2 ;
OUTER : while ( $elements < $len + 1 ) {
      my $iter = combinations( \@primes, $elements ) ;
INNER :    while ( my $p = $iter->next ) {
        if ( findSum( $p ) == $N ) {
        $line = "$elements : " ;
        $line .= join( " + " , @$p ) ;
        $line .= " = $N" ;
        last INNER ;
        last OUTER ;
              }
      }
      $elements++ ;
    }
}
if ( $line ) {
  say $line ;
}
else {
  say "$N cannot be written as the sum of prime numbers with positive sign !" ;
}
