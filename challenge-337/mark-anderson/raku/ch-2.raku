#!/usr/bin/env raku
use Test;

is odd-matrix(2,3,[[0,1],[1,1]]),             6;
is odd-matrix(2,2,[[1,1],[0,0]]),             0;
is odd-matrix(3,3,[[0,0],[1,2],[2,1]]),       0;
is odd-matrix(1,5,[[0,2],[0,4]]),             2;
is odd-matrix(4,2,[[1,0],[3,1],[2,0],[0,1]]), 8;

sub odd-matrix($rows, $cols, @locs)
{
    my @m = [0 xx $cols] xx $rows;
    @m[@locs>>[0];*]>>++;
    @m[*;@locs>>[1]]>>++;
    @m[*;*].grep(*.ends-with(any 1,3,5,7,9)).elems
}
