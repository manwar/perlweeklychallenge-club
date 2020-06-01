#!/usr/bin/perl ;
use strict ;
use warnings ;

sub rotate {
  my $str = shift ;
  my $howmany = shift ;
  return substr( $str , $howmany ) . substr( $str , 0 , $howmany ) ;
}

sub rotationNumber {
  my $str = shift ;
  my $len = length $str ;
  unless ( $str =~ /\A[xy]+\Z/ ) {
      return 0 ;
  }
  my $i = 1 ;
  my $rotations = 0 ;
  my $rotated = $str ;
  $rotated = rotate( $rotated , $i % $len ) ;
  while ( $rotated ne $str ) {
      $rotations++ ;
      $i++ ;
      $rotated = rotate( $rotated , $i % $len ) ;
  }
  return ++$rotations ;
}

print rotationNumber( "xyxx" ) ;
print "\n" ;
