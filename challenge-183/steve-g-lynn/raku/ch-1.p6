#!/usr/bin/env perl6

my @arry=([1,2],[3,4],[5,6],[1,2]);
say @arry.map(*.gist).unique;
#([1 2] [3 4] [5 6])

@arry=([9,1],[3,7],[2,5],[2,5]);
say @arry.map(*.gist).unique;
#([9 1] [3 7] [2 5])


