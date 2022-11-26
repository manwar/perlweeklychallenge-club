#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max min sum all) ;

#find a number in an array
sub findIn {
  my $array = shift ;
  my $element = shift ;
  my $pos = 0 ;
  while ( $array->[ $pos ] != $element ) {
      $pos++ ;
  }
  return $pos ;
}

say "Enter a list of integers greater than or equal to 0!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
#the sum of the array must be evenly divided by the number of elements
if ( sum( @numbers ) % ( scalar( @numbers )) != 0 ) {
  say -1 ;
}
elsif ( all { $_ == $numbers[0] } @numbers ) {
  say 0 ;
}
else {
  my $count = 0 ;
  do {
      my $maximum = max( @numbers ) ;
      my $maxPos = findIn( \@numbers , $maximum ) ;
      $numbers[ $maxPos ]-- ; #decrease the maximum element by one
      if ( $maxPos == 0 ) { #maximum element is at the left edge
    $numbers[1]++ ;
      }
      elsif ( $maxPos == (scalar( @numbers ) - 1 ) ) { #at the right edge
    $numbers[-2]++ ;
      }
      else {#increase the smaller of the 2 neighbouring elements
    if ( $numbers[ $maxPos - 1 ] < $numbers[ $maxPos + 1 ] ) {
        $numbers[ $maxPos - 1 ]++ ;
    }
    elsif ( $numbers[ $maxPos - 1 ] > $numbers[ $maxPos + 1 ] ) {
        $numbers[ $maxPos + 1 ]++ ;
    }
    else {#both neighbours are equal ; then increase the element to
          #the side of the smallest element to avoid endless loops
        my $minimum = min( @numbers ) ;
        my $minPos = findIn( \@numbers , $minimum ) ;
        if ( $minPos < $maxPos ) {
          $numbers[ $maxPos - 1 ]++ ;
        }
        else {
          $numbers[ $maxPos + 1 ]++ ;
        }
    }
      }
      $count++ ;
  } while ( not ( all { $_ == $numbers[ 0 ] } @numbers ) ) ;
  say $count ;
}
