#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

say "Enter at least 4 integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $len = scalar( @numbers ) ;
my $allPositive = 0 ;
my $allNegative = 0 ;
if (scalar( grep { $_ >= 0 } @numbers ) == $len ) {
   $allPositive = 1 ;
}
if ( scalar( grep { $_ < 0 } @numbers ) == $len ) {
   $allNegative = 1 ;
}
if ( $allPositive || $allNegative ) {
   my @sorted = sort { $a <=> $b } @numbers ;
   if ( $allPositive ) {
      my $result = $sorted[$len - 2] * $sorted[$len - 1] - $sorted[0] * 
	    $sorted[1]  ;
      say $result ;
   }
   if ( $allNegative ) {
      my $result = $sorted[0] * $sorted[1] - $sorted[$len - 2] * $sorted[$len
	    - 1]  ;
      say $result ;
   }
}
else {
   my @sorted = sort { abs( $a ) <=> abs( $b ) } @numbers ;
   my $result = $sorted[0] * $sorted[1] - $sorted[$len - 2] * 
         $sorted[$len - 1]  ;
   say $result ;
}
