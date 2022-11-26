#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a positive integer!" ;
my $number = <STDIN> ;
chomp $number ;
my @binaryDigits ;
while ( $number != 0 ) {
  push @binaryDigits , $number % 2 ;
  $number = int( $number / 2 ) ;
}
my @reversed = reverse @binaryDigits ;
for my $pos ( 0..scalar( @reversed ) - 1 ) {
  if ( $reversed[ $pos ] == 0 ) {
      $reversed[ $pos ] = 1 ;
  }
  else {
      $reversed[ $pos ] = 0 ;
  }
}
my @afterFlip = reverse @reversed ;
my $sum = 0 ;
my $multiplier = 1 ;
for my $n( @afterFlip ) {
  $sum += $n * $multiplier ;
  $multiplier *= 2 ;
}
say $sum ;
