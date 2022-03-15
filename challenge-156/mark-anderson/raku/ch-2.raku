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
    my @curr = 1, |(0 xx $sum);
    @curr[@n.head] = 1;

    for @n.skip -> $n
    {
        my @prev = @curr;

        for $n..$sum -> $i
        {
            if @curr[$i] == 0
            {
                @curr[$i] = 1 if @prev[$i-$n] == 1;
            }
        }
    }

    @curr.tail
}
