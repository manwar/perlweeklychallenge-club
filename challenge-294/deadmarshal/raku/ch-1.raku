#!/usr/bin/env raku

sub consecutive-sequence(@arr)
{
  my $s = @arr.Set;
  my $res = 0;
  for 0..@arr.end -> $i {
    unless @arr[$i]-1 ∈ $s {
      my $j = @arr[$i];
      $j++ while $j ∈ $s;
      $res = max($res,$j - @arr[$i])
    }
  }
  $res == 1 ?? -1 !! $res
}

say consecutive-sequence([10,4,20,1,3,2]);
say consecutive-sequence([0,6,1,8,5,2,4,3,0,7]);
say consecutive-sequence([10,30,20]);

