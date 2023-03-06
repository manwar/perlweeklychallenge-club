#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;
use Algorithm::Combinatorics qw ( permutations ) ;

#the pairs in a permutations must be such that the first element is not greater
#than the second
sub is_valid {
  my $permu = shift ;
  my $len = scalar( @$permu ) ;
  my $i = 0 ;
  while ( $i != $len ) {
      if ( $permu->[$i] > $permu->[ $i + 1 ] ) {
    return 0 ;
      }
      else {
    $i += 2 ;
      }
  }
  return 1 ;
}

#I'm not aware of a min function in Perl...
sub my_min {
  my $first = shift ;
  my $second = shift ;
  if ( $first < $second ) {
      return $first ;
  }
  else {
      return $second ;
  }
}
#the basic idea is to create all permutations of the position numbers of the
#array, that is from 0 to length array - 1. We then create pairs of 2 neighbouring
#numbers in these arrays. Since the order of the array is conserved, the first
#number of all of these pairs must not be greater than the second one.
#We then compute the minima of these pairs, sum them up and compare to the
#current maximum, replacing it by the sum if needed
say "Please enter an even number of integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
while ( $len % 2 != 0 ) {
  say "Please enter an even number of integers!" ;
  $line = <STDIN> ;
  chomp $line ;
  @numbers = split( /\s/ , $line ) ;
  $len = scalar( @numbers ) ;
}
my @positions = (0..$len - 1 ) ;
my $iter = permutations(\@positions) ;
my $maximum = 0 ;
while ( my $p = $iter->next ) {
  if ( is_valid( $p ) ) {
      my @minima ;
      my $i = 0 ;
      while ( $i != $len ) {
    push @minima , my_min( $numbers[ $p->[$i] ] , $numbers[ $p->[$i + 1]] ) ;
    $i += 2 ;
      }
      my $sum = sum( @minima ) ;
      if ( $sum > $maximum ) {
    $maximum = $sum ;
      }
  }
}
say $maximum ;
