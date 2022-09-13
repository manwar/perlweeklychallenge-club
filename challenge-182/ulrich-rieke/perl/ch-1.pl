#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Please enter some numbers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $maximum = $numbers[ 0 ] ;
my $maxPos = 0 ;
my %seen ;
$seen{ $maximum }++ ;
for my $i ( 1 .. scalar( @numbers ) - 1 ) {
  if ( $numbers[ $i ] > $maximum ) {
      unless ( exists ( $seen{ $numbers[ $i ] } ) ) {
    $maximum = $numbers[ $i ] ;
    $maxPos = $i ;
      }
  }
  $seen{ $numbers[ $i ] }++ ;
}
say $maxPos ;
