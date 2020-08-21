#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

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

my $S = $ARGV[ 0 ] ;
my @array = enterArray( ) ;
my $len = scalar @array ;
my @minimums ;
if ( $S > $len ) {
  say "Array too small for given window!" ;
  exit( 1 ) ;
}
else {
  for my $i (0 .. $len - $S) {
      my @partialList = @array[$i .. $i + $S - 1] ;
      push( @minimums , findMinimum( \@partialList)) ;
  }
}
print "(" ;
map { print "$_ " } @minimums ;
print ")\n" ;
