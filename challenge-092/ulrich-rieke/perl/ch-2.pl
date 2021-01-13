#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub intersection {
  my $array1 = shift ;
  my $array2 = shift ;
  my %numhash ;
  for my $elem ( @$array1 ) {
      $numhash{ $elem }++ ;
  }
  return sort { $a <=> $b } grep { exists $numhash{ $_ } } @$array2 ;
}

sub union {
  my $array1 = shift ;
  my $array2 = shift ;
  my %numhash ;
  for my $elem( @$array2 ) {
      push @$array1, $elem ;
  }
#remove double elements
  for my $elem( @$array1 ) {
      $numhash{ $elem }++ ;
  }
  return sort { $a <=> $b } keys %numhash ;
}

sub pairToArray {
  my $pair = shift ;
  my @array ;
  if ( $pair =~ /\((\d+),(\d+)\)/ ) {
      @array = ($1 .. $2) ;
  }
  return @array ;
}

sub arrayToPair {
  my $array = shift ;
  my $pair = '(' . $array->[0] . ',' . $array->[-1] . ')' ;
  return $pair ;
}

sub printArray {
  my $intervals = shift ;
  my $output ;
  for my $arr( @$intervals ) {
      $output .= arrayToPair( $arr ) ;
  }
  say $output ;
}


my @intervals = @ARGV[0 .. $#ARGV - 1] ;
my $N = $ARGV[ -1 ] ;
my @arrays ;
for my $interval( @intervals ) {
  my @array = pairToArray( $interval ) ;
  push @arrays , \@array ;
}
my $unionWasFormed = 0 ;
#if no union of $N with one of the elements of @arrays is formed
#we have to add it to the array of intervals
my @narr = pairToArray( $N ) ;
#let's see if there is an intersection of $N with any of the array
#in @arrays. If there is we can form a union of the arrays
my $i = 0 ;
my @unionIntervals ; #possible unions go here
my $len = scalar @arrays ;
while ( $i < $len ) {
  if ( my @inters = intersection( $arrays[ $i ] , \@narr ) ) {
      my @union = union( $arrays[ $i ] , \@narr ) ;
      $unionWasFormed = 1 ;
      push @unionIntervals , \@union ;
  }
  else {
      push @unionIntervals , $arrays[ $i ] ;
  }
  $i++ ;
}
if ( $unionWasFormed == 0 ) {
  push @unionIntervals , \@narr ;
}
#we sort @unionIntervals so that we can try to form a union of
#adjacent elements because they are guaranteed to be neighbouring
my @sortedIntervals = sort { $a->[0] <=> $b->[0] } @unionIntervals ;
if ( scalar @sortedIntervals == 2 ) {
  if ( my @inters = intersection( $sortedIntervals[0] ,
        $sortedIntervals[1] ) ) {
      my @union = union( $sortedIntervals[ 0 ] , $sortedIntervals[ 1 ] ) ;
      splice( @sortedIntervals, 0 , 2 , \@union ) ;
  }
}
if ( scalar @sortedIntervals == 1 ) { # we're done
  my $output = arrayToPair( $sortedIntervals[0] ) ;
  say $output ;
  exit( 0 ) ;
}
if ( scalar @sortedIntervals > 2 ) {
  my @finalIntervals ;
#that's where possible unions in a big sorted array go
  my @union ;
  my $lastelem = shift @sortedIntervals ;
  while ( @sortedIntervals ) {
      my $nextelem = shift @sortedIntervals ;
      if ( my @inters = intersection( $lastelem , $nextelem ) ) {
    @union = union( $lastelem, $nextelem ) ;
    $lastelem = \@union ;
      }
      else {
    push @finalIntervals , $lastelem ;
    $lastelem = $nextelem ;
      }
  }
  push @finalIntervals , $lastelem ;
  printArray( \@finalIntervals ) ;
}
else {
  printArray( \@sortedIntervals ) ;
}
