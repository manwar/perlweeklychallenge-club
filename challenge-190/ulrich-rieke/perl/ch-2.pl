#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( variations_with_repetition ) ;
use List::Util qw ( sum all ) ;

#this task is about finding all combinations of 1 and 2 that add up
#to the total length of $s , the number that is given at the outset.
#There is a maximum of <length of $s> 1's, admixing as many 2's as
#necessary to find a sum of <length of $s>

#we compute the maximal number of 2's in all combinations of 1 and 2
#and the minimum amount of 1's. Their sum is the shortest possible
#array of 1's and 2's that adds up to the given length of $s. The
#maximum length is the length of $s , if the array consists of 1's only
sub findCombinations {
  my $length = shift ;
  my @nums = ( 1 , 2 ) ;
  my @allCombinations ;
  my $twos = int( $length / 2 ) ;#maximal number of 2's in the array
  my $ones = $length - $twos * 2 ;#minimal number of 1's in the array
  for my $l ( ($ones + $twos)..$length ) {
      my $iter = variations_with_repetition(\@nums , $l ) ;
      while ( my $p = $iter->next ) {
    if ( sum( @$p ) == $length ) {
        push @allCombinations , $p ;
    }
      }
  }
  return @allCombinations ;
}

#function to convert an array of 1's and 2's to a word
sub arrayToWord {
  my $array = shift ;
  if ( all { $_ < 27 } @$array ) {
      my @letters = map { chr( $_ + 64 ) } @$array ;
      return join ('' , @letters ) ;
  }
  else {
      return "" ;
  }
}

say "Enter a number string!" ;
my $s = <STDIN> ;
chomp $s ;
while ( $s !~ /^\d+$/ ) {
  say "the string must consist of numbers only! Please re-enter!" ;
  $s = <STDIN> ;
  chomp $s ;
}
my @allCombinations = findCombinations( length $s ) ;
my @words ;
for my $combi ( @allCombinations ) {
  my @digits ;
  my $pos = 0 ;
  for my $num( @$combi ) {
      push @digits , substr( $s , $pos , $num ) ;
      $pos += $num ;
  }
  my $word = arrayToWord( \@digits ) ;
  if ( $word ) {
      push @words , $word ;
  }
}
say join( ',' , sort @words ) ;
