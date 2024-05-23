#!/usr/bin/env raku
use Test;

is special-positions([ 
                         [1,0,0],
                         [0,0,1],
                         [1,0,0],
                     ]),               1;

is special-positions([ 
                         [1,0,0],
                         [0,1,0],
                         [0,0,1],
                     ]),               3;

sub special-positions(@m)
{
    my @indices = @m.map({ $++, .grep(1, :k).List });
    my @cols = flat @indices>>.[1];
    @cols = (@cols (-) @cols.repeated).keys;
    @indices .= grep(*.[1] == 1);
   (@indices>>.[1] (&) @cols).elems
}
