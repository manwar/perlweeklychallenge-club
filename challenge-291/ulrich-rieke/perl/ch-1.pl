#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $len == 1 ) {
   say 0 ;
}
else {
   my $leftSum ;
   my $rightSum ;
   my $result = -1 ;
   for my $i (0..$len - 1 ) {
      if ( $i == 0 ) {
	 $leftSum = 0 ;
      }
      else {
	 $leftSum = sum( @numbers[0..$i - 1] ) ;
      }
      if ( $i == $len - 1 ) {
	 $rightSum = 0 ;
      }
      else {
	 $rightSum = sum( @numbers[$i + 1 .. $len - 1] ) ;
      }
      if ( $leftSum == $rightSum ) {
	 $result = $i ;
	 last ;
      }
   }
   say $result ;
}

