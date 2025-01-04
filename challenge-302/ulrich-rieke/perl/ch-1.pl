#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#create seed strings for the creation of a powerset!
#These are binary numbers from 1 to the number of elements in the 
#array of binary strings. A 1 in such a string means selected!
#we have to go up to 2 ^n - 1 
sub createSeedStrings {
   my $number = shift ;
   my @seedstrings ;
   my $current = $number ;
   my $len ; #maximum length of binary string
   while ( $current > 0 ) {
      my $binary = sprintf( "%b" , $current ) ;
      if ( $current == $number ) {
	 $len = length $binary ;
      }
      else {
	 my $remainder = $len - length $binary ;
	 my $firstPart = '0' x $remainder ;
	 $binary = $firstPart . $binary ;
      }
      push( @seedstrings , $binary ) ;
      $current-- ;
   }
   return @seedstrings ;
}

#create a powerset of an array by first setting up an array of binary 
#strings for all numbers from 1 to the length of the array . Then pick
#an element for every 1 in the binary string
sub powerset {
   my $array = shift ;
   my $len = scalar( @$array ) ;
   my @powSet ;
   my @seedstrings = createSeedStrings( (2 ** $len) - 1 ) ;
   for my $binstring ( @seedstrings ) {
      my @currentSet ;
      for my $pos( 0..length( $binstring ) - 1 ) {
	 if ( substr( $binstring , $pos , 1 ) eq '1' ) {
	    push( @currentSet , $array->[$pos] ) ;
	 }
      }
      push( @powSet , \@currentSet ) ;
   }
   return @powSet ;
}

sub condition {
   my $subset = shift ;
   my $x = shift ;
   my $y = shift ;
   my $zeroes = 0 ;
   my $ones = 0 ;
   for my $pos (0..scalar( @$subset ) - 1 ) {
      my $binstring = $subset->[$pos] ;
      for my $i ( 0..length( $binstring ) - 1 ) {
	 if ( substr( $binstring , $i , 1 ) eq '1' ) {
	    $ones++ ;
	 }
	 else {
	    $zeroes++ ;
	 }
      }
   }
   if ( $zeroes == $x && $ones == $y ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter some binary strings separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @binstrings = split( /\s/ , $line ) ;
say "Enter a number x for the total number of 0's!" ;
my $x = <STDIN> ;
chomp $x ;
say "Enter a number y for the total number of 1's!" ;
my $y = <STDIN> ;
chomp $y ;
my @powSet = powerset( \@binstrings ) ;
my @selected = grep { condition( $_ , $x , $y ) } @powSet ;
my @sorted = sort { scalar( @$b ) <=> scalar( @$a ) } @selected ;
say scalar( @{$sorted[0]} ) ;
