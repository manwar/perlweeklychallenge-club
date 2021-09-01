#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min ) ;

#count the number of 0's which are directly right of a given 0
sub countNeighbouringZeroes {
  my $matrix = shift ;
  my $row = shift ;
  my $col = shift ;
  my $sum = 1 ;
  my $totalCols = scalar @{$matrix->[0]} ;
  $col++ ;
  while ( $col < $totalCols ) {
      if ( $matrix->[$row]->[$col] eq '0' ) {
    $sum++ ;
    $col++ ;
      }
      else {
    last ;
      }
  }
  return $sum ;
}

#count the 0's in a given column, starting at a particular row
sub countZeroesInColumn {
  my $matrix = shift ;
  my $row = shift ;
  my $col = shift ;
  my $sum = 0 ;
  if ( $matrix->[$row]->[$col] eq '1' ) {
      return 0 ;
  }
  else {
      $sum = 1 ;
      my $len = scalar @{$matrix} ;
      $row++ ;
      while ( $row < $len ) {
    if ( $matrix->[$row]->[$col] eq '0' ) {
        $sum++ ;
    }
    $row++ ;
      }
      return $sum ;
  }
}

say "Enter 1's and 0's, separated by a blank , end to end!" ;
my $line = <STDIN> ;
chomp $line ;
my @matrix ;
while ( $line ne "end" ) {
  if ( $line =~ /([01]\s)+/ ) {
      my @submatrix = split( /\s/ , $line ) ;
      push @matrix , \@submatrix ;
  }
  else {
      say "Enter 1's and 0's, separated by a blank, [ and ] at start a. end!" ;
  }
  $line = <STDIN> ;
  chomp $line ;
}
my $rows = scalar @matrix ; # number of rows in the matrix
my $cols = scalar @{$matrix[0]} ; #number of columns in the matrix
my @zerofields ; #this array contains the widths and depths of submatrixes of 0's
#starting at a given row and column
#now we traverse the matrix row by row, column by column and look for neighbouring
#0's in the row and count the 0's in the respective columns
for my $row ( 0 .. $rows - 2 ) {
  for my $col ( 0 .. $cols - 2 ) {
      if ( $matrix[ $row ]->[$col] eq '0' ) {
    my $colAdvances = countNeighbouringZeroes( \@matrix, $row , $col ) ;
    my @zeroesInNeighbouringColumns ;
    my $currentCol = $col ;
    for my $i ( 0 .. $colAdvances - 1 ) {
        my $zeroes = countZeroesInColumn( \@matrix, $row , $currentCol + $i ) ;
        push @zeroesInNeighbouringColumns , $zeroes ;
        push @zerofields, [ 1 , $zeroes ] ;
    }
#a submatrix can only be as deep as the minimum number of 0's in a range of columns
#we also store the number of 0's in a given column
    my $minzeroes = min @zeroesInNeighbouringColumns ;
    if ( $colAdvances && $minzeroes ) {
        push @zerofields , [ $colAdvances , $minzeroes ] ;
    }
      }
  }
}
#we sort by the product of width and depth in descending order
sub byFields { ($b->[0] * $b->[1]) <=> ($a->[0] * $a->[1]) || $b->[0] <=> $a->[0]} ;
my @sorted = sort byFields @zerofields ;
my $printRow = $sorted[0]->[1] ;
my $printCol = $sorted[0]->[0] ;
for (1 .. $printRow ) {
  print "[ " ;
  for ( 1 .. $printCol ) {
      print "0 " ;
  }
  say ']' ;
}
