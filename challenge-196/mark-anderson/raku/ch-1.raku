#!/usr/bin/env raku
use Test;

is-deeply pattern_132(3,1,4,2),     (1,4,2);
is-deeply pattern_132(1,2,3,4),     ();
is-deeply pattern_132(1,3,2,4,6,5), (1,3,2);
is-deeply pattern_132(1,3,4,2),     (1,3,2);

sub pattern_132(+$list)
{
    for 0..$list-3 -> $a
    {
        for $a+1..$list-2 -> $b
        {
            for $b+1..$list-1 -> $c
            {
                return $list[$a,$b,$c] if $list[$a] < $list[$c] < $list[$b]
            }
        }
    }        

    return ()
}
