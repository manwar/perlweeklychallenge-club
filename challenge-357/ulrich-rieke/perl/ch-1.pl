#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;
#create a pair of a greater and smaller number consisting of digits in 
#descending and ascending order
sub createPair {
   my $number = shift ;
   my @digits = split( // , $number ) ;
   while ( scalar( @digits ) < 4 ) {
      push( @digits , 0 ) ;
   }
   my $firstdigit = $digits[0] ;
   if ( all { $_ == $firstdigit } @digits ) {
      return (-1 , -1 ) ;
   }
   else {
      my @ascending = sort { $a <=> $b } @digits ;
      my @descending ;
      map { push( @descending , $_ ) } @ascending ;
      @descending = reverse( @descending ) ;
      my $greater = $descending[0] * 1000 + $descending[1] * 100 +
         $descending[2] * 10 + $descending[3] ;
      my $smaller = $ascending[0] * 1000 + $ascending[1] * 100 + 
         $ascending[2] * 10 + $ascending[3] ;
      return ( $greater , $smaller ) ;
   }
}

say "Insert a positive 4-digit integer!" ;
my $number = <STDIN> ;
chomp $number ;
my @pair = createPair( $number ) ;
if ( $pair[1] == -1 ) {
   say -1 ;
}
else {
   my $count = 0 ;
   while ( $number != 6174 ) {
      my @pair = createPair( $number ) ;
      $count++ ;
      $number = $pair[0] - $pair[1] ;
   }
   say $count ;
}
