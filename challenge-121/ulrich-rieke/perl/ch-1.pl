#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub toBinaryString {
  my $number = shift ;
  my @bits ;
  while ( $number != 0 ) {
      unshift @bits , $number % 2 ;
      $number = int ( $number / 2 ) ;
  }
  return join( '' , @bits ) ;
}

sub fromBinaryString {
  my $numberstring = shift ;
  my $sum = 0 ;
  my @reversed = reverse split( // , $numberstring ) ;
  my $multiplier = 1 ;
  for my $num ( @reversed ) {
      $sum += $multiplier * $num ;
      $multiplier *= 2 ;
  }
  return $sum ;
}

my $m = $ARGV[ 0 ] ;
my $n = $ARGV[ 1 ] ;
if ( $m < 0 or $m > 255 ) {
  die "first argument should be between and including 0 and 255!\n" ;
}
if ( $n < 1 or $n > 8 ) {
  die "second argument should be between and including 1 and 8!\n" ;
}
my $numberstring = toBinaryString( $m ) ;
my $firstNibble ;
my $secondNibble ;
my $len = length $numberstring ;
if ( $len < 4 ) {
  $firstNibble = "0" x 4 ;
  $secondNibble = "0" x ( 4 - $len ) . $numberstring ;
}
if ( $len == 4 ) {
  $secondNibble = $numberstring ;
  $firstNibble = "0" x 4 ;
}
if ( $len > 4 and $len < 8 ) {
  my $newString = "0" x ( 8 - $len ) . $numberstring ;
  $firstNibble = substr( $newString , 0 , 4 ) ;
  $secondNibble = substr( $newString , 4 ) ;
}
if ( $len == 8 ) {
  $firstNibble = substr( $numberstring , 0 , 4 ) ;
  $secondNibble = substr( $numberstring , 4 ) ;
}
my $binaryString = $firstNibble . $secondNibble ;
if ( substr( $binaryString , 8 - $n , 1 ) eq "0" ) {
  substr( $binaryString , 8 - $n , 1 ) = "1" ;
}
else {
  substr( $binaryString , 8 - $n , 1 ) = "0" ;
}
say fromBinaryString( $binaryString ) ;
