#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all sum min max ) ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
say "Enter an integer x and y to denote the costs of level operations!" ;
$line = <STDIN> ;
chomp $line ;
my ( $x , $y ) = split( /\s+/ , $line ) ;
if ( all { $_ == $numbers[0] } @numbers ) {
   say 0 ;
}
else {
   my $max = max( @numbers ) ;
   my @smaller = grep { $_ < $max } @numbers ;
   my @differences = map { $max - $_ } @smaller ;
   my $totaldiff = sum @differences ;
   my $len = scalar( @smaller ) ;
   if ( $len == 1 ) {
      say ( $totaldiff * $x ) ;
   }
   else {
      my @costs ;
      for my $twos (0..int( $totaldiff / 2 ) ) {#that may two's
	 my $ones = $totaldiff - $twos * 2 ; #corresponding number of ones
         push( @costs , $ones * $x + $twos * $y ) ;
      }
      say min( @costs ) ;
   }
}

