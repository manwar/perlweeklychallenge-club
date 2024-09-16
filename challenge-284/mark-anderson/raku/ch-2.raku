#!/usr/bin/env raku
use Test;

is-deeply relative-sort((2,3,9,3,1,4,6,7,2,8,5), (2,1,4,3,5,6)), (2,2,1,4,3,3,5,6,7,8,9);
is-deeply relative-sort((3,3,4,6,2,4,2,1,3), (1,3,2)), (1,3,3,3,2,2,4,4,6);
is-deeply relative-sort((3,0,5,0,2,1,4,1,1), (1,0,3,2)), (1,1,1,0,0,3,2,4,5);

sub relative-sort($list1, $list2)
{
    my $bag := $list1.Bag;
    my $rest := ($list1 (-) $list2).keys.sort.List;
    flat (|$list2, $rest).flat.map({ $_ xx $bag{$_} })
}
