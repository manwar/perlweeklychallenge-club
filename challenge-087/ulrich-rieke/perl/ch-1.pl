#!/usr/bin/perl ;
use strict ;
use warnings ;

sub enterArray {
  my @ar ;
  print "Enter integers, -1 to end!\n" ;
  my $num = <STDIN> ;
  chomp $num ;
  while ( $num != -1 ) {
      while ( $num !~ /\d+/ ) {
    print "Wrong entry, please enter a number!\n" ;
    $num = <STDIN> ;
    chomp $num ;
      }
      push @ar , $num ;
      $num = <STDIN> ;
      chomp $num ;
  }
  return @ar ;
}

my @array = enterArray( ) ;
my @sorted = sort { $a <=> $b } @array ;#sort to possibly get consecutive number
my $current = 0 ;
my @consecutiveRuns ; #there can be a number of different consecutive sequences
my $run = [] ; #holds the last run of consecutive numbers
while ( $current < scalar @array - 1 ) {
  if ( ($sorted[ $current + 1 ] - $sorted[ $current ]) == 1 ) {
      push @$run, ($sorted[ $current] , $sorted[ $current + 1 ] ) ;
      $current += 2 ;
  }
  else {
      if ( @$run ) {#if we had consecutive numbers we must add the current number
    push @$run , $sorted[ $current ] ;
    push @consecutiveRuns , $run ; #push the last run of consecutive numbers
    $run = [] ; #start anew, empty the array reference for the next sequence
      }
      $current++ ;
  }
}
my @sortedRuns = sort { scalar @$b <=> scalar @$a } @consecutiveRuns ;
if ( @sortedRuns ) {
  my @longestRun = @{ $sortedRuns[ 0 ] } ;
  print "(" ;
  map { print "$_ " } @longestRun ;
  print ")\n" ;
}
else {
  print "0\n" ;
}
