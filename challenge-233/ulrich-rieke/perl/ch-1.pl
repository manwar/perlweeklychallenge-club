#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( product ) ;

#given a number of words with the same numbers, how many pairs can be
#created ?
sub pairnumber {
   my $n = shift ;
   my $result ;
   if ( $n == 0 || $n == 1 ) {
      $result = 0 ;
   }
   elsif ( $n == 2 ) {
      $result = 1 ;
   }
   else {
      $result = myCombinations( $n ) ;# compute the number of pairwise combis
   }
   return $result ;
}

#if the number of the same sequences of letters is greater than 2 
#the number of pair combinations is given by n! / ((n - 2 )! * 2 ) 
sub myCombinations {
   my $num = shift ;
   my $numerator = product( 1..$num) ;
   my $denom = product( 1..($num - 2 ) ) ;
   return $numerator / ( $denom * 2 ) ;
}

say "Enter some words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @words = split( /\s/ , $line ) ;
my %uniques ;#unique letters per entered word
my %lettercombis ; #all different unique letter combinations
for my $word ( @words ) {
   my @letters = split( '' , $word ) ;
   for my $l ( @letters ) {
      $uniques{ $l }++ ;#find out the unique letters
   }
#the combination of unique letters per word is sorted , then added
#to the hash with the different letter combinations
   $lettercombis{ join( '' , sort keys %uniques ) }++ ;
   %uniques = ( ) ;#we must unset the letter hash for the next word
}
my $totalpairs = 0 ;
for my $v( values %lettercombis ) {
   $totalpairs += pairnumber( $v ) ;
}
say $totalpairs ;
