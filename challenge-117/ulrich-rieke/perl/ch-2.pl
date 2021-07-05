#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#strategy and algorithm: the number $N denotes the number of levels
#at each level apart from the last one you can either descend to the next
#lower level with R or L or combine at most as many H as the level denotes.
#We then combine two levels into a merged array , element by element.
#by the time we reach the last line we check all the combinations found
#so far for validity. Every valid combination of letters is part of the
#final solution

#combine letter arrays pairwise
sub combineTwoArrays {
  my $firstArray = shift ;
  my $secondArray = shift ;
  my @combined ;
  for my $combi1 ( @$firstArray ) {
      for my $combi2 ( @$secondArray ) {
    push @combined , $combi1 . $combi2 ;
      }
  }
  return @combined ;
}

#we check the validity of a letter combination. We start out with an array
#of (0 , 0 ). An R increases the first value by 1 and the second value by 1,
#a L just the second value and a H just the first value. In $N is the input
#given we must arrive at ($N - 1 , $N - 1 ). At no time must the first
#element of the array be greater than the second element. If that occurs
#we would have "walked off" the right limit of the triangle.
#that means that the routine that checks the validity must receive a
#string and the corresponding level
sub checkValidity {
  my $lettercombi = shift ;
  my $level = shift ;
  my @startarray = (0 , 0 ) ;
  my $len = length $lettercombi ;
  for my $pos( 0 .. $len - 1 ) {
      my $letter = substr( $lettercombi, $pos , 1 ) ;
      if ( $letter eq "H" ) {
    $startarray[0] += 1 ;
      }
      elsif ( $letter eq "R" ) {
    $startarray[0] += 1 ;
    $startarray[1] += 1 ;
      }
      elsif ( $letter eq "L" ) {
    $startarray[1] += 1 ;
      }
      if ( $startarray[0] > $startarray[1] ) {
    return 0 ;
      }
  }
  if ( $startarray[ 0 ] == $level and $startarray[ 1 ] == $level ) {
      return 1 ;
  }
  else {
      return 0 ;
  }
}

#for every level we create the possible letter combinations
#we can either leave the level immediately with a L or R, or we can move
#horizontally to the right , at maximum as many times as the level allows
#after each move sideways, we can move down either by R or by L
#for the last lins a different algorithm applies
sub createLetterCombi {
  my $level = shift ;
  my @combis ;
  push @combis , "R" ;
  push @combis, "L" ;
  for my $i (1 .. $level ) {
      my $move = ("H" x $i) . "R" ;
      push @combis , $move ;
      $move = ("H" x $i ) . "L" ;
      push @combis, $move ;
  }
  return @combis ;
}

#special rules for the last line ( we can't move downwards )
sub createLastLineCombis {
  my $level = shift ;
  my @combis ;
  push @combis, "" ;
  for my $i (1 .. $level ) {
      my $move = "H" x $i ;
      push @combis, $move ;
  }
  return @combis ;
}

my $N = $ARGV[ 0 ] ;
my @solution ;
if ( $N == 1 ) {
  push ( @solution , "R" , "LH" ) ;
}
else {
  my @lastCombi = ("R" , "L" ) ;
  my @allMoves ;
  my @nextCombi ;
  for my $i ( 1 .. $N - 1 ) {
      @nextCombi = createLetterCombi( $i ) ;
      @allMoves = combineTwoArrays( \@lastCombi, \@nextCombi ) ;
      @lastCombi = @allMoves ;
  }
  @nextCombi = createLastLineCombis( $N ) ;
  @allMoves = combineTwoArrays( \@lastCombi , \@nextCombi ) ;
  @solution = grep { checkValidity( $_ , $N ) } @allMoves ;
}
say join( ',' , @solution ) ;

