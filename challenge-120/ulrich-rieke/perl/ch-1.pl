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
my $N = $ARGV[ 0 ] ;
my $numberstring = toBinaryString( $N ) ;
my $len = length $numberstring ;
my $firstNibble ;
my $secondNibble ;
if ( $len < 4 ) {
  $firstNibble = "0" x ( 4 - $len ) . $numberstring ;
  $secondNibble = "0" x 4 ;
}
if ( $len == 4 ) {
  $firstNibble = $numberstring ;
  $secondNibble = "0" x 4 ;
}
if ( $len > 4 and $len < 8 ) {
  $firstNibble = "0" x ( 8 - $len ) . substr( $numberstring , 0 , $len - 4 ) ;
  $secondNibble = substr( $numberstring , $len - 4 ) ;
}
if ( $len == 8 ) {
  $firstNibble = substr( $numberstring , 0 , 4 ) ;
  $secondNibble = substr( $numberstring , 4 ) ;
}
my $binaryString = $firstNibble . $secondNibble ;
my $swapped ;
for my $i ( 1 , 3 , 5 , 7 ) {
  $swapped .= substr( $binaryString , $i , 1 ) ;
  $swapped .= substr( $binaryString , $i - 1 , 1 ) ;
}
say fromBinaryString($swapped) ;
