#!/usr/bin/env raku

use Test;
use Prime::Factor;

nok weird(12);
nok weird(360);
nok weird(420);

ok  weird(70);
ok  weird(836);
ok  weird(7192);
ok  weird(10792);
ok  weird(12670);
ok  weird(14770);

sub weird($n)
{
    my @p = proper-divisors($n);
    return 0 if @p.sum <= $n;
    return + not subset-sum($n, @p);
}

sub subset-sum($sum, @n)
{
    my @a = 1, |(0 xx $sum);
    @a[@n.head] = 1;

    for @n.skip -> $n
    {
        for ($n..$sum).reverse -> $i
        {
            @a[$i] = @a[$i-$n] unless @a[$i]
        }
    }

    @a.tail
}
