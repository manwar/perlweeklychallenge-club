#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip ) ;

#function to repeat a given sequence until a maximum length is attained!
sub cycle_take {
   my $array = shift ;
   my $len = shift ;
   my @final_array ;
   do {
      push( @final_array , $array->[0] ) ;
      push( @final_array , $array->[1] ) ;
   } while ( scalar( @final_array) < $len ) ;
   while ( scalar( @final_array ) > $len ) {
      pop( @final_array ) ;
   }
   return @final_array ;
}

say "Enter some 0 and 1 , separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
say "Enter a positive integer!" ;
my $num = <STDIN> ;
chomp $num ;
#if the array that was input is only one element long it's false!
my $len = scalar( @numbers ) ;
if ( $len == 1 ) {
   say "false" ;
}
else {
#if we have two neighbouring 1 anywhere the answer is false!
   my $result = 0 ;
   for my $pos( 0..$len - 2 ) {
      if ( $numbers[$pos] == 1 && $numbers[$pos + 1] == 1 ) {
	 $result = 1 ;
	 last ;
      }
   }
   if ( $result ) {
      say "false" ;
   }
   else {
#we create an alternating list of 0 and 1 by using the above function cycle_take!
#depending on whether there are any 1 in the array at all we either cycle (0, 1)
#or (1 , 0). We then zip the resulting array with the initial array and count 
#the number of flips from an original 0 to 1. This number must be >= $num 
      my @comparison ;
      my @initial_array ;
      my %occurrences ;
      map { $occurrences{$_}++ } @numbers ;
      if (exists( $occurrences{1} ) ) {
	 my $pos = 0 ;
	 while ( $numbers[$pos] != 1 ) {
	    $pos++ ;
	 }
	 if ( $pos % 2 == 1 ) {
	    @initial_array = (0 , 1 ) ;
	 }
	 else {
	    @initial_array = (1 , 0 ) ;
	 }
      }
      else {
	 @initial_array = (0 , 1) ;
      }
      @comparison = cycle_take( \@initial_array , $len ) ;
      my @zipped = zip( \@numbers , \@comparison ) ;
      my $flipped = 0 ;
      for my $subarray( @zipped ) {
	 if ( $subarray->[0] == 0 && $subarray->[1] == 1 ) {
	    $flipped++ ;
	 }
      }
      if ( $flipped >= $num ) {
	 say "true" ;
      }
      else {
	 say "false" ;
      }
   }
}
