#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

say "Enter some integers >= 1 , separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( scalar( grep { $_ == $numbers[ 0 ] } @numbers ) == $len ) {
   say ( $numbers[ 0 ] * $len ) ;
}
else {
   my $sum = 0 ;
   for my $i ( 0..$len - 1 ) {
      $sum += 1 ; # representing the floor of dividing a number by itself
      if ( $i < $len - 1 ) {
	 for my $j ( $i + 1 .. $len - 1 ) {
	    if ( $numbers[ $i ] != $numbers[ $j ] ) {
	       $sum += floor( $numbers[ $i ] / $numbers[ $j ] ) ;
	       $sum += floor( $numbers[ $j ] / $numbers[ $i ] ) ;
	    }
	 }
      }
   }
   say $sum ;
}