#!usr/bin/env raku

sub special-numbers(@arr)
{
  [+] (0..@arr).map: {@arr[$_] ** 2 if @arr %% ($_+1)};
}

say special-numbers([1,2,3,4]);
say special-numbers([2,7,1,19,18,3]);
