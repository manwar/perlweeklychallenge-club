#!/usr/bin/env perl6

use v6.d;
use experimental :cached;

#| Display the first n Leonardo numbers
sub MAIN (
    Int \n = 20 # Default to 20 numbers
) {
    for ^n -> $num {
        say "L($num) : {L($num)}";
    }
}

# Combining multi subs and cached went badly
sub L( Int \n --> Int ) is pure is cached {
    return 1 if n == 0|1;
    return L(n-2) + L(n-1) + 1;
}
