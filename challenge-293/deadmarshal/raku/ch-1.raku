#!/usr/bin/env raku

sub similar-dominos(@arr)
{
  my %h;
  %h{.sort.join}++ for @arr;
  %h.values.grep: * > 1>>.sum
}

say similar-dominos([[1,3],[3,1],[2,4],[6,8]]);
say similar-dominos([[1,2],[2,1],[1,1],[1,2],[2,2]]);

