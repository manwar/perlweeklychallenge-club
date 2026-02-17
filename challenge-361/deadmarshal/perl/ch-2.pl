#!/usr/bin/env perl
use strict;
use warnings;

sub find_celebrity{
  my ($party) = @_;
  my $n = @$party;
  return -1 if $n == 0;

  my $cand = 0;
  foreach my $i(1..$n-1) {
    $cand = $i if($party->[$cand][$i]);
  }
  
  foreach my $i(0..$n-1) {
    next if $i == $cand;
    return -1 if($party->[$cand][$i] || !$party->[$i][$cand]);
  }
  $cand
}

printf "%d\n",find_celebrity([[0,0,0,0,1,0],
			      [0,0,0,0,1,0],
			      [0,0,0,0,1,0],
			      [0,0,0,0,1,0],
			      [0,0,0,0,0,0],
			      [0,0,0,0,1,0]]);
printf "%d\n",find_celebrity([[0,1,0,0],
			      [0,0,1,0],
			      [0,0,0,1],
			      [1,0,0,0]]);
printf "%d\n",find_celebrity([[0,0,0,0,0],
			      [1,0,0,0,0],
			      [1,0,0,0,0],
			      [1,0,0,0,0],
			      [1,0,0,0,0]]);
printf "%d\n",find_celebrity([[0,1,0,1,0,1],
			      [1,0,1,1,0,0],
			      [0,0,0,1,1,0],
			      [0,0,0,0,0,0],
			      [0,1,0,1,0,0],
			      [1,0,1,1,0,0]]);
printf "%d\n",find_celebrity([[0,1,1,0],
			      [1,0,1,0],
			      [0,0,0,0],
			      [0,0,0,0]]);
printf "%d\n",find_celebrity([[0,0,1,1],
			      [1,0,0,0],
			      [1,1,0,1],
			      [1,1,0,0]]);

