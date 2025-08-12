#!/usr/bin/env perl
use strict;
use warnings;

sub nearest_valid_point{
  my ($p,$x,$y) = @_;
  my ($res,$min) = (-1,1000);
  foreach my $i(0..$#$p) {
    my ($a,$b) = ($p->[$i][0],$p->[$i][1]);
    if($a == $x || $b == $y){
      my $d = abs($a - $x) + abs($b - $y);
      if($d < $min) {
	$min = $d;
	$res = $i
      }
    }
  }
  $res
}

printf "%d\n",nearest_valid_point([[1,2],[3,1],[2,4],[2,3]],3,4);
printf "%d\n",nearest_valid_point([[3,4],[2,3],[1,5],[2,5]],2,5);
printf "%d\n",nearest_valid_point([[2,2],[3,3],[4,4]],1,1);
printf "%d\n",nearest_valid_point([[0,1],[1,0],[0,2],[2,0]],0,0);
printf "%d\n",nearest_valid_point([[5,6],[6,5],[5,4],[4,5]],5,5);

