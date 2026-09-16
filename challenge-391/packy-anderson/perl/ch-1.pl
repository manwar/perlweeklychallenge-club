#!/usr/bin/env perl
use v5.44;

sub arrayMedian($arr1, $arr2) {
  my @merged;
  while (@$arr1 && @$arr2) {
    my ($v1, $v2) = (shift @$arr1, shift @$arr2);
    if ($v1 < $v2) {
      push @merged, $v1; unshift @$arr2, $v2;
    }
    else {
      push @merged, $v2; unshift @$arr1, $v1;
    }
  }
  push @merged, @$arr1;
  push @merged, @$arr2;
  my $len = scalar @merged;
  if ($len % 2 == 1) {
    return sprintf("%0.1f", $merged[int($len/2)]);
  }
  my $mid = int($len/2) - 1;
  return sprintf("%0.1f", ($merged[$mid] + $merged[$mid+1]) / 2);
}

sub solution($arr1, $arr2) {
  say 'Input: @arr1 = (' . join(', ', @$arr1) . '), @arr2 = ('
     . join(', ', @$arr2) . ')';
  say 'Output: ' . arrayMedian($arr1, $arr2);
}

say "Example 1:";
solution([2],[4]);

say "\nExample 2:";
solution([1,2,3],[7,8,9,10]);

say "\nExample 3:";
solution([],[10,20,30,40]);

say "\nExample 4:";
solution([100],[1,2,3,4,5,6,7]);

say "\nExample 5:";
solution([1,2,2],[2,2,3]);
