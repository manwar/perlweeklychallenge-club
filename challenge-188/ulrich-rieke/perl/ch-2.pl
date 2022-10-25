#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter two positive integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $x , $y ) = split( /\s/ , $line ) ;
if ( $x == $y ) {
  say 1 ;
}
else {
  my $count = 0 ;
  while ( $x != $y ) {
      if ( $x > $y ) {
    $x -= $y ;
      }
      else {
    $y -= $x ;
      }
      $count++ ;
  }
  $count++ ;
  say $count ;
}
