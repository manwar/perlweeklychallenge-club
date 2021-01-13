#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( first sum ) ;
use Algorithm::Combinatorics qw( combinations ) ;

sub enterArray {
  my @numbers ;
  print "Enter a number ( end to end ) :\n" ;
  my $number = <STDIN> ;
  chomp $number ;
  while ( $number ne "end" ) {
      if ( $number =~ /\d+/ ) {
    push( @numbers, $number ) ;
      }
      print "Enter a number ( end to end ) :\n" ;
      $number = <STDIN> ;
      chomp $number ;
  }
  return @numbers ;
}

my @array = enterArray( ) ;
#the basic idea and algorithm is: to flip the signs of numbers in the
#array in order to bring the array sum close to zero we try to find
#numbers or combinations of numbers in the array that add up to half
#the array sum. If we flip the signs of those numbers and add the rest
#the sum of the entire array is close to zero.
#the sum of all those numbers whose signs would have to be flipped is
#called $firstPart, the sum of the others $secondPart. Their difference
#is the solution
my $total = sum @array ;
my $limit = int( $total / 2 ) ;
my $firstPart ;
my $secondPart ;
my @smaller = sort { $a <=> $b } grep { $_ <= $limit } @array ;
if ( $smaller[-1] == $limit ) { #one number approximates half the array sum
  $firstPart = $limit ;
}
else {
  my $len = scalar @smaller ;
  if ( $len == 2 ) {
      $firstPart = $smaller[ 0 ] + $smaller[ 1 ] ;
  }
  else { #length of array smaller is > 2 , we ignore only 1 number
      my @combisums ; #we collect the sums of all combinations here
      for my $i ( 2 .. $len ) {
    my $iter = combinations(\@smaller , $i ) ;
    while ( my $p = $iter->next ) {
        push @combisums, sum @$p ;
    }
      }
      my @sorted = sort { $a <=> $b } @combisums ;
      $firstPart = first { $_ <= $limit } @sorted ;
  }
}
$secondPart = $total - $firstPart ;
my $diff = $secondPart - $firstPart ;
say $diff ;
