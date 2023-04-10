#!/usr/bin/env raku
use Test;

is-deeply rearrange-groups((1,2,3,5,1,2,7,6,3), 3), ((1,2,3), (1,2,3), (5,6,7));
is-deeply rearrange-groups((1,2,3), 2),             -1;
is-deeply rearrange-groups((1,2,4,3,5,3), 2),       ((1,2,3), (3,4,5));

sub rearrange-groups($list, $size)
{
    my $s = $list / $size;
    return -1 unless $s.narrow ~~ Int;
    my $b = $list.BagHash;

    gather while $b
    {
        my $sub-list = $b.sort.head($s)>>.key;
        take $sub-list;
        $b.remove($sub-list);
    }
}
