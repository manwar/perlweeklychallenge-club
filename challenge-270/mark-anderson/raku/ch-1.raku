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
    my @rows =      @m .map({ ($++,          .grep(1, :k)).join("|") });
    my @cols = ([Z] @m).map({ (.grep(1, :k), $++         ).join("|") });

    + (@rows (&) @cols)
}
