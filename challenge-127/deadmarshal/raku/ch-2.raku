#!/usr/bin/env raku

sub conflict-intervals(@arr)
{
  my @ret;
  for 1..@arr.end -> $i
  {
    my $b = False;
    for 0..^$i -> $j
    {
      $b = True if @arr[$i][0] >= @arr[$j][0] &&
				@arr[$i][0] <= @arr[$j][1];
    }
    @ret.push(@arr[$i]) if $b;
  }
  @ret;
}

say conflict-intervals([[1,4],[3,5],[6,8],[12,13],[3,20]]);
say conflict-intervals([[3,4],[5,7],[6,9],[10,12],[13,15]]);

