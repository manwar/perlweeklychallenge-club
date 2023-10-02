#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min any ) ;

sub findPosition {
  my $array = shift ;
  my $value = shift ;
  my $pos = 0 ;
  while ( $array->[$pos] != $value ) {
      $pos++ ;
  }
  return $pos ;
}

say "Enter some digits, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $len == 1 ) {
  say $numbers[ 0 ] ;
}
else {
  my @sorted = sort { $a <=> $b } @numbers ;
  while ( $len > 1 ) {
      my @differences ;
      for my $i ( 0..$len - 2 ) {
    push @differences , abs( $sorted[ $i + 1 ] - $sorted[ $i ] ) ;
      }
      if ( any { $_ != 0 } @differences ) {
    my $minimum = min( grep { $_ > 0 } @differences ) ;
    my $pos = findPosition( \@differences , $minimum ) ;
    my @inserted = ( $differences[ $pos ] ) ;
    splice( @sorted , $pos , 2 , @inserted ) ;
      }
      else {
    if ( $len > 1 ) {
        my @inserted = (0) ;
        splice( @sorted , 0 , 2 , @inserted ) ;
    }
      }
      $len = scalar( @sorted ) ;
  }
  say $sorted[ 0 ] ;
}
