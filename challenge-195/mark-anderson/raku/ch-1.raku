#!/usr/bin/env raku
use Test;

is special-integers(15),        14;
is special-integers(35),        32;
is special-integers(9_999_999), 712890;

sub special-integers($n)
{
    .elems given gather for (^10).combinations(1..$n.chars)
    {
        for .permutations
        {
            next unless .head;
           .take unless $_ > $n given .join
        }
    }
}
