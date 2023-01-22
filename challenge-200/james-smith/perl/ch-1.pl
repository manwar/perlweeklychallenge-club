#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
  [ [1..4],    '(1,2,3), (1,2,3,4), (2,3,4)' ],
  [ [1,3,4,5], '(3,4,5)' ],
  [ [1,2,3,5,6,7,9,0,-4,-8], '(0,-4,-8), (1,2,3), (5,6,7)' ],
  [ [1,1,1,1,2,3,4,6,8,10,15,20,25,50,100,125,150,175,200], '(1,1,1), (1,1,1), (1,1,1,1), (1,2,3), (1,2,3,4), (10,15,20), (10,15,20,25), (100,125,150), (100,125,150,175), (100,125,150,175,200), (125,150,175), (125,150,175,200), (15,20,25), (150,175,200), (2,3,4), (4,6,8), (4,6,8,10), (6,8,10)' ],
  [ [2],    "" ],
  [ [1,2,4,8,16,32],    "" ],
);
is( a_slices( @{$_->[0]}), $_->[1] ) foreach @TESTS;
done_testing();

## Display an array of arrays compactly...
sub d_slices { return join ', ', map { '('.join(',', @{$_}).')' } @{$_[0]}; }


sub a_slices {
  ## Less than 1 value return...
  return unless $#_;
  ## Set start of sequence to 0, d - the difference between entry 1 and entry 0
  my($st,$d,@pairs)=(0,$_[1]-$_[0]);
  ## Loop through all end points
  for(my$en=1;$en<@_;$en++) {
    ## If the gap is different - update gap (and start) and continute through loop
    if($_[$en]-$_[$en-1] != $d) {
      ($st,$d)=($en-1,$_[$en]-$_[$en-1])
    ## If it is the same add it and all alternative entries
    } else {
      ## We only store the start/end of the runs not the whole sequence
      push( @pairs, map { [$_,$en] } $st..$en-2 );
    }
  }
  ## Now we find all the start ends and return the series of each of these subsequences.
  return [ map { [ @_[ $_->[0] .. $_->[1] ] ] } @pairs ];
}

