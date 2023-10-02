#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min product ) ;

#the solution algorithm is: if only 1 integer is entered, it is the solution
#if 2 ints are entered, select the smaller of the 2 and form a product with
#the neighbours correspondingly
#if 3 integers are entered, remove the middle one and continue as above
#if more than 3 integers, remove the smallest of them and form products with
#the neighbours. If the smallest integers occurs more than once, select the
#one with the biggest product with the neighbours

sub findPosition {
  my $array = shift ;
  my $len = scalar( @$array ) ;
  if ( $len == 0 ) {
      return 0 ;
  }
  if ( $len == 1 ) {
      return 0 ;
  }
  if ( $len == 2 ) {
      if ( $array->[0] < $array->[1] ) {
    return 0 ;
      }
      else {
    return 1 ;
      }
  }
  if ( $len == 3 ) {
      return 1 ;
  }
  if ( $len > 3 ) {
      my $minimum = min( @$array ) ;
      my $howmany = grep { $_ == $minimum } @$array ;
      if ( $howmany > 1 ) {
    my $maxPos = 0 ;
    my $maxProduct = 0 ;
    for my $i ( 1 .. $len - 2 ) {
        if ( $array->[$i] == $minimum ) {
          my $product = $array->[ $i - 1 ] * $array->[ $i ] *
          $array->[$i + 1] ;
          if ( $product > $maxProduct ) {
          $maxProduct = $product ;
          $maxPos = $i ;
          }
        }
    }
    return $maxPos ;
      }
      else {
    for my $i ( 1..$len - 1 ) {
        if ( $array->[ $i ] == $minimum ) {
          return $i ;
        }
    }
      }
  }
}

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $len == 1 ) {
  say $numbers[ 0 ] ;
}
else {
  my $theSum = 0 ;
  while ( $len > 1 ) {
      my $pos = findPosition( \@numbers ) ;
      if ( $pos == 0 ) {
    $theSum += $numbers[ 0 ] * $numbers[ 1 ] ;
      }
      elsif ( $pos >= 1 && $pos < $len - 1 ) {
    $theSum += product( @numbers[ $pos - 1 , $pos + 1 ] ) ;
      }
      else {
    $theSum += $numbers[ $len - 2 ] * $numbers[ $len - 1 ] ;
      }
      splice( @numbers , $pos , 1 , ( ) ) ;
      $len = scalar( @numbers ) ;
  }
  $theSum += $numbers[ 0 ] ;
  say $theSum ;
}
