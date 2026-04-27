#!/bin/env raku

unit sub MAIN(Str:D $s1, Str:D $s2);

sub combo(*@a) {
    return @a[0] if +@a == 1;

    my @r;
    for 1..+@a-1 -> $i {
        my @A = combo(@a[^$i]);
        my @B = combo(@a[$i..*]);
        @r.push($_) for (@A X @B)».join;
        @r.push($_) for (@B X @A)».join;
    }

    @r.unique
}

my @a = $s1.comb;
put $s2 (elem) combo($s1.comb);
