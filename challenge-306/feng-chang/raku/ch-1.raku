#!/bin/env raku

unit sub MAIN(*@ints);

my $sum = 0;
for (1, 3 ... ($_ %% 2 ?? $_-1 !! $_ with +@ints)) -> $len {
    $sum += .sum for @ints.rotor($len => 1-$len);
}
put $sum;
