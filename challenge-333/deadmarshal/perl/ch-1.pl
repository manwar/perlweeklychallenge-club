#!/usr/bin/env perl
use strict;
use warnings;

sub straight_line{
  my ($m) = @_;
  my ($x1,$y1,$x2,$y2) = ($m->[0][0],$m->[0][1],$m->[1][0],$m->[1][1]);
  for(my $i = 2; $i < @$m; ++$i) {
    my ($x,$y) = ($m->[$i][0],$m->[$i][1]);
    return 0 if(($x - $x1) * ($y2 - $y1) != ($y - $y1) * ($x2 - $x1))
  }
  1
}

printf "%d\n",straight_line([[2,1],[2,3],[2,5]]);
printf "%d\n",straight_line([[1,4],[3,4],[10,4]]);
printf "%d\n",straight_line([[0,0],[1,1],[2,3]]);
printf "%d\n",straight_line([[1,1],[1,1],[1,1]]);
printf "%d\n",straight_line([[1000000,1000000],
			     [2000000,2000000],
			     [3000000,3000000]]);

