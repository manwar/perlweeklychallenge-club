#!/usr/bin/env raku
use Test;

is-deeply trim-list((1,4,2,3,5), 3), (4,5);
is-deeply trim-list((9,0,6,2,3,8,5), 4), (9,6,8,5);

sub trim-list($list, $i)
{
    $list.grep(* > $i)
}
