#!/usr/bin/env raku

say split-number(81);
say split-number(9801);
say split-number(36);

sub split-number($n)
{
    for terms($n.chars)
    {
        my @a = $n.comb.rotor($_);
        next if first { .elems > 1 and .head == 0 }, @a;
        return 1 if @a>>.join.sum == $n.sqrt;
    }

    return 0;
}

sub terms($u) 
{
    map {
            ((.fmt: '%0' ~ $u ~ 'b') ~~ m:g/(.)[$0+]?/).map(*.chars) 
        }, 1..2**($u-1)-1; 
}
