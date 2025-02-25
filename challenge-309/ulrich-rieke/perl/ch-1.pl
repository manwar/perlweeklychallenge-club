#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers in ascending order separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my $min_diff = $numbers[1] - $numbers[0] ;
my $gap_end = $numbers[1] ;
for my $pos (2..$len - 1) {
   my $current_diff = $numbers[$pos] - $numbers[$pos - 1] ;
   if ( $current_diff < $min_diff ) {
      $min_diff = $current_diff ;
      $gap_end = $numbers[$pos] ;
   }
}
say $gap_end ;
