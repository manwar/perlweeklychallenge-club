#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my @matrix ;
for (0 .. 4 ) {
  say "Enter 5 numbers, separated by a blank!" ;
  my $line = <STDIN> ;
  chomp $line ;
  my @numbers = split (/\s+/ , $line ) ;
  for my $num ( @numbers ) {
      push @matrix, $num ;
  }
}
say "Enter a number to search for: " ;
my $number = <STDIN> ;
chomp $number ;
my $lower = 0 ;
my $upper = scalar( @matrix ) - 1 ;
my $middle = int ( ($lower + $upper) / 2 ) ;
do {
  if ( $number > $matrix[ $middle ] ) { #search the right half
      $lower = $middle ;
  }
  if ( $number < $matrix[ $middle ] ) {#search the left half
      $upper = $middle ;
  }
  if ( $number != $matrix[ $middle ] ) {#we might have found the number!
      $middle = int ( ($lower + $upper) / 2 ) ;
  }
} until ( $number == $matrix[ $middle ] or ( $upper - $lower) == 1 ) ;
if ( $number == $matrix[ $middle ] ) {
  say "1 as it exists in the matrix" ;
}
if ( ($upper - $lower) == 1 ) {
  if ( $matrix[ $lower ] == $number or $matrix[ $upper ] == $number ) {
      say "1 as it exists in the matrix" ;
  }
  else {
      say "0 since it is missing in the matrix" ;
  }
}
