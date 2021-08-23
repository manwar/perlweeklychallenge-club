#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub countMines {
  my $row = shift ;
  my $col = shift ;
  my $lines = shift ;
  my $mines = 0 ;
  for my $currentRow ( $row - 1 .. $row + 1 ) {
      for my $currentCol ( $col - 1 .. $col + 1 ) {
    if ( ($currentRow > -1 && $currentRow < 5 ) &&
          ($currentCol > -1 && $currentCol < 10 ) ) {
        if ( substr( $lines->[ $currentRow ] , $currentCol , 1 ) eq
          "x" ) {
          $mines++ ;
        }
    }
      }
  }
  substr( $lines->[ $row] , $col , 1 ) = $mines ;
}

say "Enter 5 lines consisting of * and x only!" ;
my @lines ;
for ( 1 .. 5 ) {
  my $line = <STDIN> ;
  chomp $line ;
  while ( $line !~ /\A[*x]{10}\z/ ) {
      say "input should consist of 10 characters, either * or x!" ;
      $line = <STDIN> ;
      chomp $line ;
  }
  push @lines , $line ;
}
for my $row ( 0 .. 4 ) {
  for my $col ( 0 .. 9 ) {
      if ( substr( $lines[ $row ] , $col , 1 ) eq "*" ) {
    countMines( $row , $col , \@lines ) ;
      }
  }
}
map { say join( ' ' , split( // , $_ ) ) } @lines ;
