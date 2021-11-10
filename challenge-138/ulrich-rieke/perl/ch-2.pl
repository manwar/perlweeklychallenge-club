#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations_with_repetition ) ;
use POSIX ;
use List::Util qw ( sum ) ;

my $n = $ARGV[ 0 ] ;
my $root = sqrt( $n ) ;
while ( floor( $root ) != $root ) {
  say "Please enter a perfect square number!" ;
  $n = <STDIN> ;
  chomp $n ;
  $root = sqrt( $n ) ;
}
my $output = 0 ;
my @combis ; #for digits from 2 to the (length of $n) - 1, weighted
#by the number of possible occurrences of this number ;
my $len = length( $n ) ;
for my $i ( 1 .. $len - 1 ) {
  for my $j ( 1 .. int( $len / $i )) {
      push( @combis , $i ) ;
  }
}
#check whether the sum of the digits of $n equals square root
if ( sum( split (// , $n ) ) == $root ) {
  $output = 1 ;
}
else {
  my @possibleCombis ; #all those combinations where the sum of digits equals
#the length of $n
  my @combis_of_elements ; #combinations of 2 to length - 1 elements
  for my $i ( 2 .. $len - 1 ) {
      my $iter = combinations_with_repetition( \@combis , $i ) ;
      while ( my $p = $iter->next ) {
    push @combis_of_elements , $p ;
      }
      for my $combi ( @combis_of_elements ) {
    if ( sum (@$combi ) == $len ) {
        push @possibleCombis , $combi ;
        my @reversed = reverse @$combi ;
        push @possibleCombis , \@reversed ;
    }
      }
      @combis_of_elements = ( ) ;
  }
  my %combiHash ; #we want every possible combination of digits that up to
#the length of the perfect square number only once
  for my $combi ( @possibleCombis ) {
      my $str = join( ',' , @$combi ) ;
      $combiHash{ $str }++ ;
  }
  for my $combi( keys %combiHash ) {
      my @splitnumbers = split( /,/ , $combi ) ;
      my $sum = 0 ;
      my $currentPos = 0 ;
      for my $num ( @splitnumbers ) {
    $sum += ( substr( $n , $currentPos , $num ) + 0 ) ;
    $currentPos += $num ;
      }
      if ( $sum == $root ) {
    $output = 1 ;
    last ;
      }
  }
}
say $output ;
