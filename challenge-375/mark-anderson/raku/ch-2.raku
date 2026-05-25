#!/usr/bin/env raku
use Test;

is k-beauty(240,  2), 2;
is k-beauty(1020, 2), 3;
is k-beauty(444,  2), 0;
is k-beauty(17,   2), 1;
is k-beauty(123,  1), 2;

sub k-beauty($n, $k)
{
    .elems given $n ~~ m:ov/ \d ** {$k} <?{ $n %% $/ }> /
}
