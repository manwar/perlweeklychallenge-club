#!/bin/env raku

# https://www.mathblog.dk/project-euler-44-smallest-pair-pentagonal-numbers/
# is-pentagonal() is key to speed it up

my UInt $i = 1;
 
outer-loop:
loop {
    ++$i;
    my UInt \n = pentagon($i);

    loop (my UInt $j = $i - 1; $j > 0; --$j) {
        my UInt \m = pentagon($j);
        if is-pentagonal(n - m) && is-pentagonal(n + m) {
            put "\n", n, ' ', m;
            last outer-loop;
        }
    }
    print "{$i}\r";
}

sub pentagon(UInt:D \n --> UInt:D) {
    n * (3 * n - 1) div 2
}

sub is-pentagonal(UInt:D \n --> Bool:D) {
    my \p = (sqrt(1.0 + 24 * n) + 1.0) / 6.0;
    p == p.UInt
}
