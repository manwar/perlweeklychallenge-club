#!/usr/bin/env perl
use strict;
use warnings;

sub boomerang{
  my ($a) = @_;
  ($a->[1][1] - $a->[0][1]) * ($a->[2][0] - $a->[1][0]) !=
    ($a->[2][1] - $a->[1][1]) * ($a->[1][0] - $a->[0][0])
}

printf "%d\n",boomerang([[1,1],[2,3],[3,2]]);
printf "%d\n",boomerang([[1,1],[2,2],[3,3]]);
printf "%d\n",boomerang([[1,1],[1,2],[2,3]]);
printf "%d\n",boomerang([[1,1],[1,2],[1,3]]);
printf "%d\n",boomerang([[1,1],[2,1],[3,1]]);
printf "%d\n",boomerang([[0,0],[2,3],[4,5]]);

