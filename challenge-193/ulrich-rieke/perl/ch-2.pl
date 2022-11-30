#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findDifference {
  my $word = shift ;
  my @positions = map { (ord $_) - 97 } split( // , $word ) ;
  my @result ;
  while ( scalar( @result ) != 1 ) {
      my $len = scalar( @positions ) ;
      for my $i ( 0..$len - 2 ) {
    push @result , $positions[ $i + 1 ] - $positions[ $i ] ;
      }
#if the array of differences in @result contains more than 1 number,
#we clear the positions array and transfer all elements of @result into
#it until @result has only one element
      if ( scalar( @result ) > 1 ) {
    @positions = ( ) ;
    for my $r ( @result ) {
        push @positions , $r ;
    }
    @result = ( ) ;
      }
  }
  return $result[0] ;
}

#find the index of a given number in an array
sub findIndex {
  my $array = shift ;
  my $num = shift ;
  my $pos = 0 ;
  while ( $array->[$pos] != $num ) {
      $pos++ ;
  }
  return $pos ;
}

say "Enter some strings of equal length, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @strings = split ( /\s/ , $line ) ;
my @differences = map { findDifference( $_ ) } @strings ;
my $pos ;
my $result ;
my @underNil = grep { $_ < 0 } @differences ;
if ( scalar( @underNil ) == 1 ) {
  $pos = findIndex( \@differences, $underNil[0] ) ;
  $result = $strings[ $pos ] ;
}
else {
  my @nils = grep { $_ == 0 } @differences ;
  if ( scalar( @nils ) == 1 ) {
      $pos = findIndex( \@differences , $nils[0] ) ;
      $result = $strings[ $pos ] ;
  }
  else {
      my @overnil = grep { $_ > 0 } @differences ;
      if ( scalar( @overnil ) != 1 ) {
    $result = "There appears to be no distinctive string!" ;
      }
      else {
    $pos = findIndex( \@differences, $overnil[0] ) ;
    $result = $strings[ $pos ] ;
      }
  }
}
say $result ;
