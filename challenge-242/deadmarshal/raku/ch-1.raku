#!/usr/bin/env raku

sub missing-members(@a,@b)
{
  grep { .Bool }, ((@a (-) @b), (@b (-) @a))>>.keys>>.sort>>.Array
}

say missing-members([1,2,3],[2,4,6]);
say missing-members([1,2,3,3],[1,1,2,2]);

