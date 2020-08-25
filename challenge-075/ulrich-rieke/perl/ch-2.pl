#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findMinMax {
  my $array = shift ;
  my @sorted = sort { $a <=> $b } @{$array} ;
  return ( $sorted[ 0 ] , $sorted[ -1 ] ) ;
}

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

sub printRectangle {
  my $array = shift ;
  my $maximum = (findMinMax( $array ))[ 1 ] ;
  my $currentNumber = $maximum ;
  my $len = scalar @{$array} ;
  say " " ;
  while ( $currentNumber > 0 ) {
      print $currentNumber ;
      my $line ;
      for my $i ( 0 .. $len - 1 ) {
    if ( $array->[ $i ] >= $currentNumber ) {
        $line .= " #" ;
    }
    else {
        $line .= "  " ;
    }
      }
      print "$line\n" ;
      $currentNumber-- ;
  }
  print "- " x $len ;
  print "-\n" ;
  print "  " ;
  print join( ' ' , @{$array} ) ;
  say " " ;
}

#the task is equivalent to forming groups of neighboring numbers
#(at least 2 , at most the entire array). The minimum of this
#group represents the height of the rectangle, the number of
#neighbouring numbers its width. We seek the maximum product of
#all possible groups in the array
my @array = enterArray( ) ;
printRectangle( \@array ) ;
my $len = scalar @array ;
my @areas ;
my $minimum ;
my @partialArray ;
my $area ;
for my $width ( 2 .. $len - 1 ) {
  for my $startindex ( 0 .. $len - $width ) {
      @partialArray = @array[ $startindex .. $startindex + $width - 1] ;
      my $minimum = (findMinMax( \@partialArray))[0] ;
      $area = $width * $minimum ;
      push( @areas , $area ) ;
  }
}
$minimum = ( findMinMax(\@array) )[ 0 ] ;
$area = $minimum * $len ;
push( @areas , $area ) ;
my $maximum = (findMinMax(\@areas))[ 1 ] ;
say $maximum ;
