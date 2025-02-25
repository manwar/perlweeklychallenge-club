#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(current_sub);
use List::Util qw(sum0);

sub matchstick_square{
  my ($arr) = @_;
  return 0 if sum0(@$arr) % 4 != 0;
  my $len = sum0(@$arr) / 4;
  @$arr = sort{$b <=> $a} @$arr;
  my @sides = (0) x 4;
  my $dfs = sub {
    my ($i) = @_;
    return $len == $sides[0] == $sides[1] ==
      $sides[2] == $sides[3] if $i == @$arr;
    foreach my $j(0..3){
      if($sides[$j] + $arr->[$i] <= $len){
	$sides[$j] += $arr->[$i];
	return 1 if(__SUB__->($i+1));
	$sides[$j] -= $arr->[$i]
      }
    }
    0
  };
  $dfs->(0)
}

printf "%d\n",matchstick_square([1,2,2,2,1]);
printf "%d\n",matchstick_square([2,2,2,4]);
printf "%d\n",matchstick_square([2,2,2,2,4]);
printf "%d\n",matchstick_square([3,4,1,4,3,1]);

