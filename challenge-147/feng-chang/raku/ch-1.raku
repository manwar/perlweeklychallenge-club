#!/bin/env raku

unit sub MAIN(UInt:D \num = 20);

my @lefty-primes = 2, 3, 5, 7;
my ($start, $end) = 0, 3;

my UInt $sz = @lefty-primes.elems;

while $sz < num {
    for 1..9 -> \d {
        for @lefty-primes[$start..$end] -> \n {
            my \m = (d ~ n).UInt;
            if m.is-prime {
                @lefty-primes.push(m);
                ++$sz;
            }
        }
    }
    ($start, $end) = $end + 1, $sz - 1;
    last if $end < $start;
}

put @lefty-primes[^((num,$sz).min)];
