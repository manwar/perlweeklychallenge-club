#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub max_distance{
  my @pairs = map{
    my $x = $_;
    map {[$x,$_]} @{$_[1]}
  } @{$_[0]};
  max map {abs $_->[0] - $_->[1]} @pairs;
}

printf "%d\n",max_distance([4,5,7],[9,1,3,4]);
printf "%d\n",max_distance([2,3,5,4],[3,2,5,5,8,7]);
printf "%d\n",max_distance([2,1,11,3],[2,5,10,2]);
printf "%d\n",max_distance([1,2,3],[3,2,1]);
printf "%d\n",max_distance([1,0,2,3],[5,0]);

