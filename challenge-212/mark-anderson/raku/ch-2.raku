#!/usr/bin/env raku
use Test;

is-deeply rearrange-groups((1,2,3,5,1,2,7,6,3), 3), ((1,2,3), (1,2,3), (5,6,7));
is-deeply rearrange-groups((1,2,3), 2),             -1;
is-deeply rearrange-groups((1,2,4,3,5,3), 3),       ((1,2,3), (3,4,5));
is-deeply rearrange-groups((1,5,2,6,4,7), 3),       -1;

sub rearrange-groups($list, $size)
{
    return -1 unless ($list.elems / $size).narrow ~~ Int;
    my $b = $list.BagHash;

    eager gather while $b
    {
        my $sub-list = $b.sort.head($size)>>.key;
        return -1 unless .tail - .head == .end and [<] $_ given $sub-list;
        take $sub-list;
        $b.remove($sub-list)
    }
}
