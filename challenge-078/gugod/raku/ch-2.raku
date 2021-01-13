#!/usr/bin/env raku

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/#TASK2
#
# # raku ./challenge-078/gugod/raku/ch-2.raku --a=7,4,2,6,3 --b=1,3,4
# [4 2 6 3 7]
# [6 3 7 4 2]
# [3 7 4 2 6]

sub rot($n, @A) {
    return @A[ $n .. *, 0 .. $n-1 ].flat;
}

sub MAIN (
    Str :$a,
    Str :$b,
) {
    my @A = $a.split(",");
    my @B = $b.split(",");

    for @B -> $n {
        say rot($n, @A);
    }
}
