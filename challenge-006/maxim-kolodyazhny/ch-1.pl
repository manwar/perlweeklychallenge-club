#!/usr/bin/env perl -p

# echo 1,2,3,4,42,43,45 | ch-1.pl

s{
    (\b \d+)
    (,?\d+,)+
    (\d+ \b)
    (??{
        # this block is treated as a pattern
        # ne will return '' (always match) or 1 (fail because of previous \b)
        $& ne join(',', $1..$3);
    })
}
{$1-$3}xg;
