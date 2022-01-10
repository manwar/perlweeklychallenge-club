#!/usr/bin/env raku

# Through trial and error I came up with the ~2200 figure.

my @p = reverse (1..2200).map(&pentagonal);

for @p X @p
{
    if is-pentagonal(.head + .tail) and is-pentagonal(abs(.head - .tail))
    {
        say .head ~ ", " ~ .tail;
        last;
    }
}

sub pentagonal(\n)
{
    n * (3 * n - 1) / 2
}

sub is-pentagonal(\n)
{
    return (((sqrt(24 * n + 1)) + 1) / 6).narrow ~~ UInt;
}
