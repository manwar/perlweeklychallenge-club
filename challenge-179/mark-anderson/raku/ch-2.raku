#!/usr/bin/env raku
use Test;

is sparkline(2,4,6,8,10,12,14,16), '▁▂▃▄▅▆▇█';

sub sparkline(+$list)
{
    my @blocks = "\c[Lower One Eighth Block]" .. "\c[Full Block]";

    return @blocks[ $list.map(&new-x) ].join;

    sub new-x($x)
    {
        # https://stackoverflow.com/a/47555593
        (7 * ($x - $list.min) / ($list.max - $list.min)).round
    }
}
