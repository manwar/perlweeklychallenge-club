#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub find_left_array {
  my $array = shift ;
  my @left_array ;
  my $len = scalar( @$array ) ;
  my $limit = int( $len / 2 ) ;
  push @left_array , 0 ;
  my $left_sum = 0 ;
  for my $i ( 0..$limit ) {
      $left_sum += $array->[ $i ] ;
      push @left_array, $left_sum ;
  }
  return @left_array ;
}

sub find_right_array {
  my $array = shift ;
  my @right_array ;
  my $len = scalar( @$array ) ;
  my $left_limit ;
  if ( $len % 2 == 1 ) {
      $left_limit = int( $len / 2 ) ;
  }
  else {
      $left_limit = int( $len / 2 ) - 1 ;
  }
  my $right_sum = 0 ;
  for my $i( $left_limit..$len - 1 ) {
      $right_sum += $array->[ $i ] ;
  }
  push @right_array , $right_sum ;
  for my $i( $left_limit..$len - 1 ) {
      $right_sum -= $array->[ $i ] ;
      push @right_array , $right_sum ;
  }
  push @right_array , 0 ;
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
