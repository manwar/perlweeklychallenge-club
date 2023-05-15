#!/usr/bin/env raku

sub number-placement(@arr,$count)
{
  my $c = 0;
  for 1..^@arr.end -> $i
  {
    $c++ if all(@arr[$i-1],@arr[$i+1]) == 0;
  }
  $c >= $count;
}

say number-placement([1,0,0,0,1],1);
say number-placement([1,0,0,0,1],2);
say number-placement([1,0,0,0,0,0,0,0,1],3);

