#!/usr/bin/env raku

say (4..100).grep(&brazilian);

sub brazilian($n where * > 3)
{
    for 2..($n-2, 36).min
    {
        return 1 if [eq] $n.base($_).comb
    }

    return 0
}
