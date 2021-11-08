#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#distance of 2 points
sub computeDistance {
  my $point1 = shift ;
  my $point2 = shift ;
  my @coordinates1 = @$point1 ;
  my @coordinates2 = @$point2 ;
  return sqrt( (($coordinates2[0] - $coordinates1[0]) ** 2 ) +
    ((($coordinates2[1] - $coordinates1[1] ) ** 2) )) ;
}

my @points ;
say "Enter point coordinates ( numbers , separated by blanks )!" ;
for my $i ( 1 .. 4 ) {
  say "Enter $i. point!" ;
  my $line = <STDIN> ;
  chomp $line ;
  my @point = split( /\s+/ , $line ) ;
  push @points , \@point ;
}
my %distances ;
#it is required that all neighbouring points have the same distance
for my $i (0 .. 2) {
  my $distance = computeDistance( $points[ $i ] , $points[ $i + 1 ] ) ;
  $distances{ $distance }++ ;
}
my $distance = computeDistance( $points[0] , $points[ 3 ] ) ;
$distances{ $distance }++ ;
#it is required that the diagonals have the same length
my %diagonals ;
$distance = computeDistance( $points[ 0 ] , $points[ 2 ] ) ;
$diagonals{ $distance }++ ;
$distance = computeDistance( $points[ 1 ] , $points[ 3 ] ) ;
$diagonals{ $distance }++ ;
#there should be only one length in the %distances and %diagonals hashes
if ( (scalar( keys %distances ) == 1 ) && ( scalar( keys %diagonals )
    == 1 )) {
  say 1 ;
}
else {
  say 0 ;
}
