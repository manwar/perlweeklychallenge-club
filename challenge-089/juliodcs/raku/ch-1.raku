#! /usr/bin/raku

sub gcd-sum($n) {
    (1 .. $n).combinations(2).map({[gcd] @^it}).sum
}

######## MAIN and TESTS ########

if @*ARGS == 1 {
    say gcd-sum @*ARGS.head.Int;
    exit 0
}

use Test;

is gcd-sum(3), 3, 'gcd-sum of 3';
is gcd-sum(4), 7, 'gcd-sum of 4';

done-testing;
