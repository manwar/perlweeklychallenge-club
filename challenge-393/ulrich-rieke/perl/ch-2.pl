#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;
use List::Util qw ( all sum ) ;

#unfortunately, the beautiful given..when syntax appears to be in 
#a deplorable state of being experimental, not so experimental , 
#partially deprecated and so on from version to version, so I go
#back to the roots...
sub isPrime {
   my $number = shift ;
   my $val ;
   if ( $number == 0 ) {
      $val = 0 ;
   }
   elsif ( $number == 1 ) {
      $val = 0 ;
   }
   elsif ( $number == 2 ) {
      $val = 1 ;
   }
   else {
      my $root = floor( sqrt( $number ) ) ;
      if ( all { $number % $_ != 0 } (2..$root)) {
         $val = 1 ;
      }
      else {
         $val = 0 ;
      }
   }
   return $val ;
}

say "Enter a word consisting of English alphabetic characters only!" ;
my $word = <STDIN> ;
chomp $word ;
my $total = sum( map { ord( $_ ) } split( // , $word ) ) ;
if ( isPrime( $total )) {
   say 0 ;
}
else {
   my $upper_prime ;
   my $lower_prime ;
   my $current = $total + 1 ;
   while ( not isPrime( $current ) ) {
      $current += 1 ;
   }
   $upper_prime = $current ;
   $current = $total - 1 ;
   while ( not isPrime( $current ) ) {
      $current -= 1 ;
   }
   $lower_prime = $current ;
   if ( $upper_prime - $total <= $total - $lower_prime ) {
      say ( $upper_prime - $total ) ;
   }
   else {
      say ( $total - $lower_prime ) ;
   }
}
