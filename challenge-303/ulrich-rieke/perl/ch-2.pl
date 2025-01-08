#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;
use Algorithm::Combinatorics qw ( permutations ) ;

#we create sublists by making a list of sublists from a permutation of the
#original number input. we pass down a permutation to see whether neighbouring
#numbers are 1 apart from each other
sub createListPartitions {
   my $array = shift ;
   my @sublists ;
   my @currentList ;
   push( @currentList , $array->[0] ) ;
   my $len = scalar( @$array ) ;
   for my $i (1..$len - 1 ) {
      if ( abs( $currentList[0] - $array->[$i] ) == 1 ) {
	 push( @currentList , $array->[$i] ) ;
      }
      else {
	 push( @sublists , [@currentList] ) ;
	 @currentList = ( ) ;
	 push( @currentList , $array->[$i] ) ;
      }
   }
   if ( scalar( @currentList ) > 0 ) {
      push( @sublists , [@currentList] ) ;
   }
   return @sublists ;
}

#the sum of a partition is the sum of the first numbers of its subarrays since
#the other members are deleted
sub findSum {
   my $parts = shift ;
   my $sum = 0 ;
   for my $subarray( @$parts ) {
      $sum += $subarray->[0] ;
   }
   return $sum ;
}

say "Enter some integers separated by whitespace!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @allSums ;
my $iter = permutations(\@numbers) ;
while ( my $p = $iter->next ) {
   my @parts = createListPartitions( $p ) ;
#   print '(' ;
#   for my $subarray (@parts) {
#      print '[' . join( ',' , @$subarray ) . ']' ;
#   }
#   say ')' ;
   my $currentSum = findSum(\@parts) ;
   push( @allSums , $currentSum ) ;
}
say max( @allSums ) ;
