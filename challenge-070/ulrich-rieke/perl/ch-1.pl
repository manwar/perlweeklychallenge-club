#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub swapLetters {
  my $word = shift ;
  my $firstPos = shift ;
  my $secondPos = shift ;
  my $temp = substr( $word , $secondPos , 1 ) ;
  substr( $word , $secondPos , 1 ) = substr( $word, $firstPos , 1 ) ;
  substr( $word , $firstPos , 1 ) = $temp ;
  return $word ;
}

my $word = $ARGV[0] ;
my $C = $ARGV[ 1 ] ;
my $O = $ARGV[ 2 ] ;
my $len = length $word ;
for my $i ( 1..$C ) {
  $word = swapLetters( $word , $i % $len , ( $i + $O ) % $len ) ;
}
say $word ;
