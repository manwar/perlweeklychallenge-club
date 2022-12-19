#!/usr/bin/env raku
use Test;

is-deeply pattern-acb(3,1,4,2),     (1,4,2);
is-deeply pattern-acb(1,2,3,4),     ();
is-deeply pattern-acb(1,3,2,4,6,5), (1,3,2);
is-deeply pattern-acb(1,3,4,2),     (1,3,2);

sub pattern-acb(+$list)
{
    for 0..$list-1 -> $a
    {
        for $a+1..$list-1 -> $b
        {
            for $b+1..$list-1 -> $c
            {
                return $list[$a,$b,$c] if $list[$a] < $list[$c] < $list[$b]
            }
        }
    }        

    return ()
}
