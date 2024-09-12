#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( pairs min max ) ;

say "Enter 2 ^ n integers , where n is a positive integer!" ;
my $line = <STDIN> ;
chomp $line ;
#I do no input checking here...
my @numbers = split( /\s+/ , $line ) ;
my $last_was_min = 0 ;#did we determine the minimum last time, if not , 0!
while ( scalar( @numbers ) > 1 ) {
   my @pairs = pairs( @numbers ) ;
   my @intermediate ; #for the minima and maxima
   for my $pair ( @pairs ) {
      if ( $last_was_min ) { #we now have to find the maximum
	 push( @intermediate , max( @$pair ) ) ;
	 $last_was_min = 0 ; #toggle the boolean value
      }
      else { #the other way round
	 push( @intermediate , min( @$pair ) ) ;
	 $last_was_min = 1 ;
      }
   }
   @numbers = @intermediate ;
   @intermediate = ( ) ;
}
say $numbers[0] ;
