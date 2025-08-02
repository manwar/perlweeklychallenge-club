#!/bin/env raku

unit sub MAIN(*@ints);

my \y = @ints.pop;
my \x = @ints.pop;

my @a = @ints.sort;
my \mx = @a[*-1];

if 2*x ≤ y {
    put @a.map(mx - *).sum * x;
    exit 0;
}

my $score = 0;
loop {
    @a .= grep(* < mx).Array;
    last unless @a;

    ++@a[0];
    if +@a > 1 {
        ++@a[1];
        $score += y;
    } else {
        $score += x;
    }

    @a .= sort;
}
put $score;
