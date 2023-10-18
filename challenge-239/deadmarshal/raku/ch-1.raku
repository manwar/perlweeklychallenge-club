#!/usr/bin/env raku

sub same-string(@arr1,@arr2)
{
  @arr1.join eq @arr2.join
}

say same-string(["ab","c"],["a","bc"]);
say same-string(["ab","c"],["ac","b"]);
say same-string(["ab","cd","e"],["abcde"]);

