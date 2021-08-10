#!/usr/bin/env raku

#
# https://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_triples#Dickson's_method
#

use Prime::Factor;

multi MAIN($N)
{
    .say for py-tris($N);
}

multi MAIN
{
    use Test;
    plan 9;

    is py-tris(1), -1;
    is py-tris(2), -1;
    is-deeply py-tris(3),  ((3, 4, 5),);
    is-deeply py-tris(5),  ((3, 4, 5), (5, 12, 13));
    is-deeply py-tris(6),  ((6, 8, 10),);
    is-deeply py-tris(13), ((5, 12, 13), (13, 84, 85));
    is-deeply py-tris(15), ((8, 15, 17), (9, 12, 15), (15, 20, 25), (15, 36, 39), (15, 112, 113));
    is-deeply py-tris(33), ((33, 44, 55), (33, 56, 65), (33, 180, 183), (33, 544, 545));
    is-deeply py-tris(40), ((9, 40, 41), (24, 32, 40), (30, 40, 50), (40, 42, 58), (40, 75, 85), (40, 96, 104), (40, 198, 202), (40, 399, 401));
}

multi py-tris($N where * == 1|2) { -1 }

multi py-tris($N where * == 3|4) { (3, 4, 5), }

multi py-tris($N where * > 0)
{
    gather
    {
        SEQ: for 2, 4 ... * -> $r
        {
            for factor-pairs(($r**2 / 2).Int) -> ($s, $t)
            {
                my $x = $r + $s;
                my $y = $r + $t;
                my $z = $r + $s + $t;

                take ($x, $y, $z) if any($x, $y, $z) == $N;
                last SEQ if $x == $N and $z - $y == 1|2;
            }
        }
    }
}

sub factor-pairs($n)
{
    my @divs = proper-divisors($n);
    @divs .= grep(* < sqrt($n));
    @divs.map({ $_, $n div $_ });
}
