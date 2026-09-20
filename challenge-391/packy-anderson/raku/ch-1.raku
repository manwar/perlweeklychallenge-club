#!/usr/bin/env raku
use v6;

sub arrayMedian(@arr1, @arr2) {
  my @merged;
  while (@arr1 && @arr2) {
    my ($v1, $v2) = (@arr1.shift, @arr2.shift);
    if ($v1 < $v2) {
      @merged.push($v1); @arr2.unshift($v2);
    }
    else {
      @merged.push($v2); @arr1.unshift($v1);
    }
  }
  @merged.append(@arr1);
  @merged.append(@arr2);
  my $len = @merged.elems;
  if ($len % 2 == 1) {
    return sprintf("%0.1f", @merged[($len div 2)]);
  }
  my $mid = ($len div 2) - 1;
  return sprintf("%0.1f", (@merged[$mid] + @merged[$mid+1]) / 2);
}

sub solution(@arr1, @arr2) {
  say 'Input: @arr1 = (' ~ @arr1.join(', ') ~ '), @arr2 = ('
     ~ @arr2.join(', ') ~ ')';
  say 'Output: ' ~ arrayMedian(@arr1, @arr2);
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
