#!/usr/bin/perl ;
use strict ;
use warnings ;

sub digitsum {
  my $number = shift ;
  my $sum = 0 ;
  map { $sum += $_ } split ( // , $number ) ;
  return $sum ;
}

my $N = $ARGV[0] ;
my $S = $ARGV[1] ;
my $lowest = '1' . '0' x ( $N - 1 ) ;
my $highest = '9' . '9' x ( $N - 1 ) ;
map { print "$_\n" } grep { digitsum( $_ ) == $S } ($lowest..$highest) ;
