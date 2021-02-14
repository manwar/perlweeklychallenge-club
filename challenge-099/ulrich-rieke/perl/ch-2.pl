#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;
use Algorithm::Combinatorics qw ( combinations_with_repetition ) ;

#find the different subsequences of $T according to numbers
sub findChunks {
  my $word = shift ;
  my $numbers = shift ;
  my @chunks ;
  my $pos = 0 ;
  for my $num ( @$numbers ) {
      push @chunks , substr( $word , $pos , $num ) ;
      $pos = $num ;
  }
  return @chunks ;
}

#if we have an array of chunks, see whether all chunks can be found in
#$S in the right order. If this is so add the number of the possible
#combinations to the total number of combinations
sub findSubstrings {
  my $longword = shift ;
  my $chunks = shift ;
  my $combis = 0 ; #how often can we find the chunks in the right order ?
  my $regex = "" ;#we apply this regex to find the chunks in $longword
  my $len = scalar @$chunks ;
  if ( $len == 1 ) {
      $regex = "$chunks->[0]" ;
      while ( $longword =~ /$regex/g ) {
    $combis++ ;
      }
  }
  else {
      my @startpositions ; #that's where the positions of the first chunk go
      $regex = "$chunks->[0]" ;
      while ( $longword =~ m/$regex/g ) {
    push @startpositions, pos $longword ;
      }
#we look for the rest of the chunks from every position in @startpositions
      $regex = "\.\+\?" ; #at least one character after the first chunk,
      #non-greedily
      for my $i (1 .. $len - 1 ) {
    $regex .= "$chunks->[ $i ]" ;
    if ( $i != $len - 1 ) {
        $regex .= "\.\+\?" ;#we don't want to add this after the last chunk
    }
      }
      for my $searchstart ( @startpositions ) {
    pos $longword = $searchstart ;
    while ( $longword =~ m/$regex/g ) {
        $combis++ ;
    }
      }
  }
  return $combis ;
}

#how many ways are there to find a combination of all numbers from 1
#to the length of $T

sub findAllCombinations {
  my $number = shift ;
  my @allCombis ;#contains all number combination that add up to $number
  my @subarray ;
  for (1 .. $number) {
      push @subarray, 1 ;
  }
  push @allCombis , \@subarray ;
  push @allCombis, [ $number ] ;
  my @combinations ;#all combinations of numbers 1 .. $num - 1
  my @numbers = (1 .. $number - 1 ) ;
  for my $i ( 2 .. $number - 1 ) {
      for my $combi ( combinations_with_repetition( \@numbers , $i ) ) {
    push @combinations, $combi ;
    my @reversed = reverse @$combi ;
    if ( join( '' , @reversed ) ne join( '' ,  @$combi ) ) {
        push @combinations , \@reversed ;
    }
      }
  }
  my @fitting = grep { (sum @{$_}) == $number } @combinations ;
  for my $combi ( @fitting ) {
      push @allCombis, $combi ;
  }
  return @allCombis ;
}

my $S = $ARGV[0] ;
my $T = $ARGV[ 1 ] ;
if ( length $T > length $S ) {
  die "second string should be shorter than first one!" ;
}
my @numbercombis = findAllCombinations( length $T ) ;
my @chunkcombis ;
for my $combi ( @numbercombis ) {
  my @chunks = findChunks( $T , $combi ) ;
  push @chunkcombis , \@chunks ;
}
my $combinations = 0 ;
for my $combi ( @chunkcombis ) {
  $combinations += findSubstrings( $S , $combi ) ;
}
say $combinations ;
