#!/usr/bin/env raku

sub array-loops(@arr)
{
  my ($i,$count) = (0) xx 2;
  my @indices = False xx @arr.elems;
  while $i < @arr.elems {
    if @indices[$i] == False {
      $count++;
      until @indices[$i] {
	@indices[$i] = True;
	$i = @arr[$i];
      }
    }
    $i++;
  }
  $count
}

say array-loops([4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10]);
say array-loops([0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19]);
say array-loops([9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17]);

