#!/usr/bin/env raku
use Test;

is-deeply range-list(1,3,4,5,7),       ((3,5),);
is-deeply range-list(1,2,3,6,7,9),     ((1,3), (6,7));
is-deeply range-list(0,1,2,4,5,6,8,9), ((0,2), (4,6), (8,9));

sub range-list(+$list)
{
    my ($h, $t) = (0, 0);

    my $a := gather for $list.rotor(2 => -1, :partial)
    {
        if .tail - .head == 1
        {
            $t++
        }

        else
        {
            take $h, $t if $h < $t;
            $t++;
            $h = $t
        }
    }

    $list[$a]
}
