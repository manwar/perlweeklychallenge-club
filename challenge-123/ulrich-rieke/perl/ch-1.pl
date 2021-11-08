#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#we keep dividing the number passed as argument until it is equal to 1
#we start with the divisor 2
#in the end we check if only 2 , 3 or 5 occurred as divisors
#after joining the divisors into a string we apply a regular expression
#to it
sub isUgly {
  my $num = shift ;
  my %divisors ;
  my $current = 2 ;
  while ( $num > 1 ) {
      if ( ($num % $current) == 0 ) {
    $divisors{$current}++ ;
    $num /= $current ;
      }
      else {
    $current++ ;
      }
  }
  my $str = join( '' , sort { $a <=> $b } keys %divisors ) ;
  return ( $str =~ /\b[235]+\b/ ) ;
}

my $n = $ARGV[ 0 ] ;
my $current = 1 ; #1 assumed to be an ugly number
my $sumUglies = 1 ;#see above
while ( $sumUglies < $n ) {
  $current++ ;
  if (isUgly ( $current ) ) {
      $sumUglies++ ;
  }
}
say $current ;
