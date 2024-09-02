#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

say "Enter an amount of money in pennies!" ;
my $amount = <STDIN> ;
chomp $amount ;
my $combis = 0 ;
for my $pennies( 0..$amount) {
   for my $nickels( 0..floor( $amount / 5 ) ) {
      for my $dimes( 0..floor( $amount / 10 ) ) {
	 for my $quarters( 0..floor( $amount / 25 ) ) {
	    for my $half_dollars( 0..floor( $amount / 50 ) ) {
	       if ( $pennies + $nickels * 5 + $dimes * 10 + $quarters * 25
		     + $half_dollars * 50 == $amount ) {
		  $combis++ ;
	       }
	    }
	 }
      }
   }
}
say $combis ;
