#!/usr/bin/env raku

sub left-right-sum-diff(@arr)
{
  my ($left,$right) = (0,@arr[1..@arr.end].sum);
  my @diffs;
  for 0..@arr.end
  {
    @diffs.push(abs $left - $right);
    $left += @arr[$_];
    $right -= $_ < @arr.end ?? @arr[$_+1] !! 0;
  }
  @diffs
}

say left-right-sum-diff([10,4,8,3]);
say left-right-sum-diff([1]);
say left-right-sum-diff([1,2,3,4,5]);

