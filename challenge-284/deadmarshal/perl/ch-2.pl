#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub relative_sort{
  my (%ranks,%ranked);
  $ranks{$_[1]->[$_]} = $_ foreach 0..$#{$_[1]};
  $ranked{$_} = defined $ranks{$_} ? 1 : 0 foreach @{$_[0]};
  sort{
    ($ranked{$b} <=> $ranked{$a}) ||
      ($ranks{$a} || 0) <=> ($ranks{$b} || 0) ||
      $a <=> $b
  } @{$_[0]}
}

print show relative_sort([2,3,9,3,1,4,6,7,2,8,5],[2,1,4,3,5,6]);
print show relative_sort([3,3,4,6,2,4,2,1,3],[1,3,2]);
print show relative_sort([3,0,5,0,2,1,4,1,1],[1,0,3,2]);

