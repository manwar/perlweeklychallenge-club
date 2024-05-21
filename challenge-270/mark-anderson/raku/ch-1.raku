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
    @m .=      grep(*.grep(1).one);
    + ([Z] @m).grep(*.grep(1).one)
}
