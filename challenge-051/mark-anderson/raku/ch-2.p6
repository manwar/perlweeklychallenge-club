#!/usr/bin/env perl6

for 100 .. 999 -> $num {
    my @digits = $num.comb.unique;

    if @digits == 3 {
        if (([*] @digits), ([*] @digits[0,1]), ([*] @digits[1,2])).Set == 3 {
            say $num;
        }
    }
}
