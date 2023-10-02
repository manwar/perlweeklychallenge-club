#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#to make the examples fit I assume that in order to form the left subarray
#you go to the element given by the length of the array, integer divided
#by 2 , + 1
sub find_left_array {
  my $array = shift ;
  my @left_array ;
  my $len = scalar( @$array ) ;
  my $limit ;
  if ( $len % 2 == 1 ) {
      $limit = int( $len / 2 ) + 1 ;
  }
  else {
      $limit = int( $len / 2 ) ;
  }
  push @left_array , 0 ;
  my $left_sum = 0 ;
  for my $i ( 0..$limit ) {
      $left_sum += $array->[ $i ] ;
      push @left_array, $left_sum ;
  }
  return @left_array ;
}

#to make the examples fit , I assume that the right subarray is formed by
#the sum of all elements inclusively from the length of the array, integer
#divided by 2 , - 1 , and subsequent subtractions of all further right
#array elements from the sum
sub find_right_array {
  my $array = shift ;
  my @right_array ;
  my $len = scalar( @$array ) ;
  my $left_limit = int( $len / 2 ) - 1 ;
  my $right_sum = 0 ;
  for my $i( $left_limit..$len - 1 ) {
      $right_sum += $array->[ $i ] ;
  }
  push @right_array , $right_sum ;
  for my $i( $left_limit..$len - 1 ) {
      $right_sum -= $array->[ $i ] ;
      push @right_array , $right_sum ;
  }
  return @right_array ;
}

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $len == 1 ) {
  say "(0)" ;
}
else {
  my @result ;
  my @left_array = find_left_array( \@numbers ) ;
  my @right_array = find_right_array( \@numbers ) ;
  for my $i (0..scalar( @left_array) - 1 ) {
      push @result , abs( $left_array[ $i ] - $right_array[ $i ] ) ;
  }
  say "(" . join( ',' , @result ) . ")" ;
}
