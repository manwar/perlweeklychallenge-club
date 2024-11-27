#!/usr/bin/env raku

sub boomerang(@a)
{
  (@a[1][1] - @a[0][1]) * (@a[2][0] - @a[1][0]) !=
  (@a[2][1] - @a[1][1]) * (@a[1][0] - @a[0][0])
}

say boomerang([[1,1],[2,3],[3,2]]);
say boomerang([[1,1],[2,2],[3,3]]);
say boomerang([[1,1],[1,2],[2,3]]);
say boomerang([[1,1],[1,2],[1,3]]);
say boomerang([[1,1],[2,1],[3,1]]);
say boomerang([[0,0],[2,3],[4,5]]);

