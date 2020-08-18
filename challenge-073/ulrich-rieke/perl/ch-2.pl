#!/usr/bin/perl ;
use strict ;
use warnings ;

sub enterArray {
  my @array ;
  print "Enter a number ( end to end ) :\n" ;
  my $number = <STDIN> ;
  chomp $number ;
  while ( $number ne "end" ) {
      if ( $number =~ /\d+/ ) {
    push( @array, $number ) ;
      }
      print "Enter a number ( end to end ) :\n" ;
      $number = <STDIN> ;
      chomp $number ;
  }
  return @array ;
}

sub allEqual {
  my $array = shift ;
  my $value = $array->[0] ;
  for my $i ( 1 .. scalar @{$array} - 1 ) {
      if ( $array-[$i] != $value ) {
    return 0 ;
      }
  }
  return 1 ;
}

sub findMinimum {
  my $array = shift ;
  my $minimum = $array->[0] ;
  for my $i (1..scalar @{$array} - 1 ) {
      if ( $array->[ $i ] < $minimum ) {
    $minimum = $array->[ $i ] ;
      }
  }
  return $minimum ;
}

my @A = enterArray( ) ;
my $len = scalar @A ;
my @smallNeighbours ;
my @leftOf ;
push( @smallNeighbours, 0 , $A[ 0 ] ) ;
for my $i ( 2 .. $len - 1 ) {
  @leftOf = @A[0 .. $i - 1 ] ;
  if ( allEqual( \@leftOf ) ) {
      push( @smallNeighbours , 0 ) ;
  }
  else {
      push( @smallNeighbours, findMinimum( \@leftOf ) ) ;
  }
}
print "(" ;
map { print "$_ " } @smallNeighbours ;
print ")\n" ;
