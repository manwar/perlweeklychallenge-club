#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( combinations ) ;

sub enterMatrix {
  my $rows = shift ;
  my $columns = shift ;
  my @matrix ;
  for my $currentrow ( 0..$rows - 1 ) {
      for my $currentcol (0..$columns - 1 ) {
    say "Enter 1 or 0!" ;
    my $n = <STDIN> ;
    chomp $n ;
    while ( $n !~ /^[01]$/ ) {
        say "Enter 1 or 9!" ;
        $n = <STDIN> ;
        chomp $n ;
    }
    push @{$matrix[ $currentrow]} , $n ;
      }
  }
  return @matrix ;
}

sub findIndicesofOne {
  my $array = shift ;
  my @indices ;
  for my $i (0..scalar @$array - 1 ) {
      if ( $array->[ $i ] == 1 ) {
    push @indices , $i ;
      }
  }
  return @indices ;
}

sub countOnes { #count the number of 1's in a row
  my $array = shift ;
  return scalar grep { $_ == 1 } @$array ;
}

sub existCorrespondingCorners { #are there corresponding square corners ?
  my ( $matrix , $rowIndex , $firstOne , $secondOne ) = @_ ;
  my $diff = $secondOne - $firstOne ;
  return ( defined $matrix->[$rowIndex + $diff] and
    $matrix->[$rowIndex + $diff][$firstOne] == 1 and
        $matrix->[$rowIndex + $diff][$secondOne] == 1 ) ;
}

my $m = $ARGV[ 0 ] ;
my $n = $ARGV[ 1 ] ;
my @matrix = enterMatrix( $m, $n ) ;
my @possibleStartRows ; #all those rows in the matrix with more than one 1
for my $i (0..$#matrix) {
  if ( countOnes( $matrix[ $i ] ) > 1 ) {
      push @possibleStartRows, $i ;
  }
}
#if there are no or less than 2 rows with two 1's there can be no square
if ( scalar @possibleStartRows < 2 ) {
  say "\n0" ;
}
else {
  my $squaresum = 0 ;
  for my $rowIndex( @possibleStartRows ) {
      if ( $rowIndex < $#matrix ) {
    my @ones = findIndicesofOne ( $matrix[ $rowIndex ] ) ;
    my $iter = combinations (\@ones , 2 ) ;
    while ( my $p = $iter->next ) {
        if ( existCorrespondingCorners( \@matrix, $rowIndex, $p->[0] ,
            $p->[1] ) ) {
          $squaresum++ ;
        }
    }
      }
  }
  say "\n$squaresum" ;
}
