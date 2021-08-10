#!/usr/bin/env raku

# Caveat: This program grabs all Pythagorean triples (not just the primitives)

# py-tris uses the Dickson method
# https://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_triples#Dickson's_method

# factor-pairs uses the Rainbow method
# https://www.chilimath.com/lessons/introductory-algebra/finding-all-the-factors-of-a-whole-number-using-the-rainbow-method

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
    is-deeply py-tris(4),  ((3, 4, 5),);
    is-deeply py-tris(5),  ((3, 4,  5), (5, 12, 13));
    is-deeply py-tris(6),  ((6, 8, 10),);
    is-deeply py-tris(13), ((5, 12, 13), (13, 84, 85));
    is-deeply py-tris(15), ((8, 15, 17), (9, 12, 15), (15, 20, 25), (15, 36, 39), (15, 112, 113));
    is-deeply py-tris(33), ((33, 56, 65), (33, 180, 183), (33, 544, 545));
}

multi py-tris($N where * == 1|2) { -1 }

multi py-tris($N where * == 3|4) { (3,4,5), }

multi py-tris($N where * > 0)
{
    gather
    {
        SEQ: for 2, 4 ... * -> $r
        {
            for factor-pairs(($r**2/2).Int) -> $p
            {
                my $x = $r + $p[0];
                my $y = $r + $p[1];
                my $z = $r + $p[0] + $p[1];
        
                take ($x, $y, $z) if any($x, $y, $z) == $N;
                last SEQ if $x == $N and $z - $y == 1|2;
            }
        }
    }
}

sub factor-pairs($n)
{
    gather
    {
        for 1..9 -> $div
        {
            if $n %% $div
            {
                my $tail = $n div $div;
                last if $div > $tail;
                take ($div, $tail);
            }
        }
    }
}
