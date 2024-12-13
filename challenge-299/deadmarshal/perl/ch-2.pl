#!/usr/bin/env perl
use strict;
use warnings;

my @dir = ([-1,0],[0,1],[1,0],[0,-1]);

sub word_search{
  my ($chars,$str) = @_;
  my $visited;
  foreach my $i(0..$#$chars){
    foreach my $j(0..$#{$chars->[0]}){
      return 1 if helper($chars,$visited,$str,0,$i,$j)
    }
  }
  0
}

sub is_inside{
  my ($chars,$x,$y) = @_;
  $x >= 0 && $x < @$chars && $y >= 0 && $y < @{$chars->[0]}
}

sub helper{
  my ($chars,$visited,$word,$index,$x,$y) = @_;
  if($index eq length($word)-1) {
    return $chars->[$x][$y] eq substr($word,$index,1)
  }
  if($chars->[$x][$y] eq substr($word,$index,1)) {
    $visited->[$x][$y] = 1;
    foreach my $i(0..$#dir) {
      my ($nx,$ny) = ($x + $dir[$i][0],$y + $dir[$i][1]);
      return 1 if is_inside($chars,$nx,$ny) &&
	!$visited->[$nx][$ny] &&
	helper($chars,$visited,$word,$index+1,$nx,$ny)
    }
  }
  0
}

printf "%d\n",word_search([['A', 'B', 'D', 'E'],
			   ['C', 'B', 'C', 'A'],
			   ['B', 'A', 'A', 'D'],
			   ['D', 'B', 'B', 'C']],'BDCA');
printf "%d\n",word_search([['A', 'A', 'B', 'B'],
			   ['C', 'C', 'B', 'A'],
			   ['C', 'A', 'A', 'A'],
			   ['B', 'B', 'B', 'B']],'ABAC');
printf "%d\n",word_search([['B', 'A', 'B', 'A'],
			   ['C', 'C', 'C', 'C'],
			   ['A', 'B', 'A', 'B'],
			   ['B', 'B', 'A', 'A']],'CCCAA');

