#!/usr/bin/env raku
use Test;

is prefix-suffix([<a aba ababa aa>]),  4;
is prefix-suffix([<pa papa ma mama>]), 2;
is prefix-suffix([<abao ab>]),         0;
is prefix-suffix([<abab abab>]),       1;
is prefix-suffix([<ab abab ababab>]),  3;
is prefix-suffix([<abc def ghij>]),    0;

sub prefix-suffix(@arr)
{
    @arr .= sort: { .chars }

    .sum given gather for ^@arr.end
    {
        my $head = @arr.shift;
        take +@arr.grep: { .starts-with($head) and .ends-with($head) }
    }
}
