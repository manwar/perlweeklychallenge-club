#!/usr/bin/env raku

sub sorted-matrix(@arr)
{
  @arr.map({|$_}).sort({$^a <=> $^b})[2];
}

say sorted-matrix([[3,1,2],[5,2,4],[0,1,3]]);
say sorted-matrix([[2,1],[4,5]]);
say sorted-matrix([[1,0,3],[0,0,0],[1,2,1]]);

