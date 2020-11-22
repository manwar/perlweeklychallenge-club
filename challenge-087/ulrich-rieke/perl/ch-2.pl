#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( all ) ;

sub enterArray {
  my ( $row, $cols ) = @_ ;
  my  @array ;
  my $line ;
  say "Enter rows consisting only of 0 and 1!" ;
  for (0 .. $row - 1 ) {
      $line = <STDIN> ;
      chomp $line ;
      while ( $line !~ /\A[01]+\Z/ ) {
    say "line should only consist of 0 and 1! Enter a new line!" ;
    $line = <STDIN> ;
    chomp $line ;
      }
      push @array , $line ;
  }
  return @array ;
}

#from any given point in the array, defined by the upper line and the upper
#left column, find a rectangle that is defined by $width and $depth
#we attach the characters that we find to a result string
#if it is a rectangle the result string contains only '1'

sub findRectangle {
  my ($array, $lineLeftUpper , $colLeftUpper, $width , $depth ) = @_ ;
  my $result ;
  for my $i ( 0 .. $width - 1 ) {
      for my $j ( 0 .. $depth - 1 )  {
        $result .= substr ($array->[$lineLeftUpper + $j] ,  $colLeftUpper + $i , 1 ) ;
      }
  }
  if ( $result =~ /^1+$/ ) {
      return [$width, $depth ] ;
  }
  else {
      return [0 , 0 ] ;
  }
}

my $m = $ARGV[ 0 ] ;
my $n = $ARGV[ 1 ] ;
my @array = enterArray( $m , $n ) ;
my @rectangles ;
#for every point in the array with enough room left for a minimum rectangle of width
#2 and depth 2 , look for a possible rectangle originating at that point
#if they consist of 1 only store the corresponding width and depth ( right and down )
#in the array @rectangles . In the end , sort this array in descending order with
#the product of width and depth as the sorting criterion
for my $rowUpperLeft (0 .. $m - 2 ) {
  for my $colUpperLeft (0 .. $n - 2 ) {
      for my $w (2 .. $n - $colUpperLeft ) {
    for my $d (2 .. $m - $rowUpperLeft )  {
        push @rectangles ,  findRectangle(\@array , $rowUpperLeft, $colUpperLeft ,
            $w , $d ) ;
    }
      }
  }
}
if ( all { $_->[0] == 0 and $_->[1] == 0 } @rectangles ) {
  say 0 ;
}
else {
  my @sorted = sort { ($b->[1] * $b->[0]) <=> ($a->[0] * $a->[1] ) } @rectangles ;
  my $outputline = '1' x $sorted[0]->[0] ; #the first el. of $sorted[0] holds the width
  for (0 .. $sorted[0]->[1] - 1 ) { #print as many lines as depth indicates
      print "[ " ;
      map { print "$_ " } split (// , $outputline ) ;
      print " ]\n" ;
  }
}
