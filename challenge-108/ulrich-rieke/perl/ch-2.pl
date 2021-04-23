#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my @bellnumbers = ( 1 ) ;
my @current_row ; #for the row we collect numbers in
my @previous_row = ( 1 ) ; #the last row we created
while ( scalar @bellnumbers < 10 ) {
  push @current_row , $previous_row[ -1 ] ;
  my $current_index = 0 ;
  do {
      $current_index++ ;
      $current_row[ $current_index] = $current_row[ $current_index - 1]
    + $previous_row[ $current_index - 1] ;
  } while ( scalar @current_row < scalar @previous_row + 1 ) ;
  push @bellnumbers , $current_row[ 0 ] ;
  @previous_row = @current_row ;
  @current_row = ( ) ;
}
say "These are the first 10 Bell numbers!" ;
for my $i (1 .. 10 ) {
  if ( $i < 10 ) {
      print " $i : " ;
  }
  else {
      print "$i : " ;
  }
  say $bellnumbers[ $i - 1 ] ;
}
