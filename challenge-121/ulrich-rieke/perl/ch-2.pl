#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

#find a number in a row
sub findColumn {
  my $array = shift ;
  my $number = shift ;
  my @row = @$array ;
  my $column = 0 ;
  while ( $row[ $column ] != $number ) {
      $column++ ;
  }
  return $column ;
}

#find the next city to visit ; it's the column with the smallest number
#next to 0 provided the city wasn't visited yet
sub findNextCity {
  my $array = shift ;
  my $placesSeen = shift ;
  my @row = @$array ;
  my %visited = %{$placesSeen} ;
  my @sorted = sort { $a <=> $b } @row ;
  my $i = 1 ;
  my $column = findColumn( \@row , $sorted[ $i ] ) ;
  while ( exists $visited{ $column } ) {
      $i++ ;
      $column = findColumn( \@row , $sorted[ $i ] ) ;
  }
  return $column ;
}

my @matrix = ( [0, 5, 2, 7] , [5, 0, 5, 3] , [3, 1, 0, 6] , [4, 5, 4, 0] ) ;
my @tour ;
my $len = scalar @matrix ;
my %visited ;
my $startPlace = 0 ;
my $currentPlace = $startPlace ;
$visited{ $startPlace }++ ;
push @tour , 0 ;
while ( scalar ( keys %visited ) < $len ) {
  my $column = findNextCity( $matrix[ $currentPlace ] , \%visited ) ;
  push @tour , $matrix[ $currentPlace ][$column] ;
  $currentPlace = $column ;
  $visited{ $currentPlace }++ ;
}
#we must return to the start
push @tour , $matrix[ $currentPlace ][$startPlace] ;
my $length = sum ( @tour ) ;
say "length = $length" ;
say "tour = (" . join( ' ' , @tour ) . ")" ;
