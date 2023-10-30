#!/usr/bin/env raku

sub similar-words(@arr)
{
  my ($count,%h) = (0);
  @arr.map: {%h{$_.comb.sort.unique.join}++};
  $count += ($_ * ($_-1)) / 2 for %h.values;
  $count
}

say similar-words(["aba","aabb","abcd","bac","aabc"]);
say similar-words(["aabb","ab","ba"]);
say similar-words(["nba","cba","dba"]);

