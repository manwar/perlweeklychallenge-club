#!/bin/env raku

sub coins-sum(Int:D @C, Int:D $S, Int:D @solution) {
    { say @solution; return; } if $S == 0;
    return if $S < @C[0];

    my Int @coins = @C;
    while @coins.elems > 0 {
        my Int @Sol = @solution;
        @Sol.push(@coins[0]);
        coins-sum(@coins, $S - @coins[0], @Sol);

        @coins.shift;
    }
}

my Int @coins = 1, 2, 4;
my Int @solution;
coins-sum(@coins, 6, @solution);
