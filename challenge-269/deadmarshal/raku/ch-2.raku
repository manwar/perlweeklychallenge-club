#!/usr/bin/env raku

sub distribute-elements(@arr)
{
  my @ret1 = @arr.shift;
  my @ret2 = @arr.shift;
  while @arr {
    my $e = @arr.shift;
    @ret1[*-1] > @ret2[*-1] ?? @ret1.push($e) !! @ret2.push($e)
  }
  (@ret1,@ret2).flat
}

say distribute-elements([2,1,3,4,5]);
say distribute-elements([3,2,4]);
say distribute-elements([5,4,3,8]);

