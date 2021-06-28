#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub checkCondition {
  my $number = shift ;
  if ( $number =~ /11/ ) {
      return 0 ;
  }
  my $ones = 0 ;
  my $twos = 0 ;
  my $threes = 0 ;
  my $len = length $number ;
  for my $i ( 0 .. $len - 1 ) {
      my $substr = substr( $number , $i , 1 ) ;
      if ( $substr eq "1" ) {
    $ones++ ;
      }
      if ( $substr eq "2" ) {
    $twos++ ;
      }
      if ( $substr eq "3" ) {
    $threes++ ;
      }
  }
  if ( $ones + $twos + $threes == $len ) {
      return 1 ;
  }
  return 0 ;
}

my $N = $ARGV[ 0 ] ;
my @numbers = ( 1 ) ;
my $current = 1 ;
while ( scalar( @numbers ) < $N ) {
  $current++ ;
  if ( checkCondition( $current ) ) {
      push @numbers , $current ;
  }
}
say $numbers[ -1 ] ;
