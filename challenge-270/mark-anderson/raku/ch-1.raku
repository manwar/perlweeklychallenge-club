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
    my $cols = @m.map({ .grep(1, :k).List }).List;
    my $uniq-cols = ($cols.flat (-) $cols.flat.repeated).keys.List;
    + ($cols.grep(1) (&) $uniq-cols)
}
