#!/usr/bin/perl ;
use strict ;
use warnings ;
use List::Util qw( max sum ) ;
use Algorithm::Combinatorics qw( combinations ) ;

sub gcd {
  my ( $firstNum , $secondNum ) = @_ ;
  my $gcd ;
  if ( $firstNum == 1 or $secondNum == 1 ) {
      $gcd = 1 ;
  }
  else {
      $gcd = max grep { $firstNum % $_ == 0 and $secondNum % $_ == 0 } (1..$firstNum) ;
  }
  return $gcd ;
}

my $N = $ARGV[ 0 ] ;
my @gcds ;
my @data = (1..$N) ;
my $iter = combinations(\@data , 2 ) ;
while ( my $p = $iter->next ) {
  push @gcds , gcd ($p->[0] , $p->[1] ) ;
}
my $sum = sum @gcds ;
print "$sum\n" ;
