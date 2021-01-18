#!/usr/bin/env raku

# https://en.wikipedia.org/wiki/Levenshtein_distance
# Iterative with full matrix algorithm

multi MAIN(Str:D $s, Str:D $t)
{
    say levenshtein-distance($s, $t)
}

multi MAIN 
{
    use Test;
    plan 4;

    is levenshtein-distance("kitten",   "sitting"),3, "kitten   -> sitting = 3";
    is levenshtein-distance("sunday",   "monday"), 2, "sunday   -> monday  = 2";
    is levenshtein-distance("saturday", "sunday"), 3, "saturday -> sunday  = 3";
    is levenshtein-distance("abxcd",    "abcd"),   1, "abxcd    -> abcd    = 1";
}

sub levenshtein-distance(Str:D $s, Str:D $t --> Int:D) 
{
    my ($m, $n) = $s.chars+1, $t.chars+1;

    my @d = [0 xx $m] xx $n;

    @d.head = [^$m];

    @d.map: { .head = $++ }

    for 1..^$m X 1..^$n -> ($i, $j)  
    {
        @d[$j;$i] = min @d[$j-1;$i  ] + 1,
                        @d[$j  ;$i-1] + 1,
                        @d[$j-1;$i-1] + +(($s.substr: $i-1, 1)  
                                      ne  ($t.substr: $j-1, 1)) 
    }    

    @d[$n-1;$m-1]
}
