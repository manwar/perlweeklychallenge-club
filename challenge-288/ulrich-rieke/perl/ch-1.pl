#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isPalindrome {
   my $number = shift ;
   if ( $number eq join( '' , reverse( split( // , $number )))) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter a number!" ;
my $number = <STDIN> ;
chomp $number ;
my $current = $number ;
$current-- ;
while ( not ( isPalindrome( $current ) ) ) {
   $current-- ;
}
my $minusnum = $current ;
my $minusdiff = abs( $minusnum - $number ) ;
$current = $number + 1 ;
while ( not ( isPalindrome( $current ) ) ) {
   $current++ ;
}
my $plusnum = $current ;
my $plusdiff = abs( $plusnum - $number ) ;
if ( $plusdiff == $minusdiff ) {
   say $minusnum ;
}
else {
   if ( $plusdiff < $minusdiff ) {
      say $plusnum ;
   }
   else {
      say $minusnum ;
   }
}
