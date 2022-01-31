#!/usr/bin/env raku

use Test;

is largest-square(2),  '1';
is largest-square(4),  '3201';
is largest-square(10), '9814072356';
is largest-square(12), 'B8750A649321';

sub largest-square(\base)
{
    my $d = (base.pred...0).map({.base(base)}).join
                           .parse-base(base).sqrt.floor;

    loop
    {
        my \b = ($d-- ** 2).base(base);
        return b unless b.comb.repeated;
    }
}
