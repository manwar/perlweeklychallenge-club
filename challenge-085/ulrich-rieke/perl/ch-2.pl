#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#the basic idea is : the integers must be between 2 and the square root of n
#so we cycle through that range
my $N = $ARGV[0] ;
my $powerlimit = 0 ;
my $upperlimit = int( sqrt( $N ) ) ;
for my $i (2..$upperlimit) {
  my $exponent = 2 ;
  my $power = $i ** $exponent ;
  while ( $power < $N ) {
      $exponent++ ;
      $power = $i ** $exponent ;
  }
  if ( $power == $N ) { #yes , $N can be expressed as the power of 2 integers
      $powerlimit = 1 ;
      last ;
  }
}
say $powerlimit ;
