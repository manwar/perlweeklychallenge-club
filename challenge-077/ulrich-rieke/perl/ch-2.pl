#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub enterArray {
  my $m = shift ;
  my $n = shift ;
  my @array ;
  say "Please enter $n lines consisting of o and x only!" ;
  while ( scalar @array < $n ) {
      say "Next line : " ;
      my $line = <STDIN> ;
      chomp $line ;
      if ( length $line == $m ) {
    push( @array , $line ) ;
      }
      else {
    say "line should be $m characters long!" ;
      }
  }
  return @array ;
}

my $m = $ARGV[ 0 ] ;
my $n = $ARGV[ 1 ] ;
my @allIndices ; #contains the indices of all x'es
my @array = enterArray( $m , $n ) ;
for my $line ( @array ) {
  my @xindices ; #holds the indices of x'es per line
  for my $i (0..$m - 1 ) {
      if ( substr( $line , $i , 1 ) eq 'x' ) {
    push ( @xindices, $i ) ;
      }
  }
  push( @allIndices, \@xindices ) ;
}
my @allNeighbours ;
for my $row ( 0..$n - 1 ) {
  my $rowstring = $array[ $row ] ;
  my @indices = @{$allIndices[ $row ]} ;
  if ( @indices ) {
      for my $xcolumn ( @indices ) {
    my $neighbours ;
    if ( $xcolumn > 0 )  {#left
        $neighbours .= substr( $rowstring , $xcolumn - 1 , 1 ) ;
    }
    if ( $xcolumn < $m - 1 ) {#right
        $neighbours .= substr( $rowstring , $xcolumn + 1 , 1 ) ;
    }
    if ( $row > 0 ) { #above
        $neighbours .= substr( $array[ $row - 1 ] , $xcolumn, 1 ) ;
    }
    if ( $row < $n - 1 ) { #below
        $neighbours .= substr( $array[ $row + 1 ] , $xcolumn , 1 ) ;
    }
    if ( $row > 0 && $xcolumn > 0 ) {#diagonally left up
        $neighbours .= substr( $array[ $row - 1 ] , $xcolumn - 1 , 1 ) ;
    }
    if ( $row > 0 && $xcolumn < $m - 1 ) {#diagonally right up
        $neighbours .= substr( $array[ $row - 1 ] , $xcolumn + 1 , 1 ) ;
    }
    if ( $row < $n - 1 && $xcolumn > 0 ) {#diagonally left down
        $neighbours .= substr( $array[ $row + 1 ] , $xcolumn - 1 , 1 ) ;
    }
    if ( $row < $n - 1 && $xcolumn < $m - 1 ) {#diagonally right down
        $neighbours .= substr( $array[ $row + 1 ] , $xcolumn + 1 , 1 ) ;
    }
    push ( @allNeighbours, $neighbours ) ;
      }
  }
}
say scalar  grep { $_ !~ /x/ } @allNeighbours ;
