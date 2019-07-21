#!/usr/bin/env perl6
use v6;

use experimental :cached;

multi sub MAIN(:$test) {
    use Test;

    my @tests =
        [ 1, 2, 4 ],
        [ 3, 50, 9007199254740989 ],
        [ 4, 2, (2 ** 2 ** 2 ** 2 ** 2) - 3 ],
        [ 5, 0, 65533 ],
    ;

    for @tests -> $test {
        is A($test[0], $test[1]), $test[2], "A($test[0],$test[1])";
    }

    done-testing;
}

multi sub MAIN(UInt:D $m, UInt:D $n) {
   say A($m, $n);
}

multi sub A(0,                     UInt:D $n --> UInt:D) { $n + 1 }
multi sub A(UInt:D $m,             0         --> UInt:D) { A( $m-1, 1 ) }

# This is a shortcut based on Wikipedia information - lets me compute
# A(5,0) for instance.
multi sub A(UInt:D $m where * > 2, UInt:D $n --> UInt:D) { up-arrow(2, $m-2, $n+3) - 3 }

multi sub A(UInt:D $m,             UInt:D $n --> UInt:D) { A( $m-1, A($m, $n-1) ) }

multi sub up-arrow(UInt:D $m, UInt:D $num-arrows, 0         --> UInt:D) { 1 }
multi sub up-arrow(UInt:D $m, 1,                  UInt:D $n --> UInt:D) { $m ** $n }
multi sub up-arrow(UInt:D $m, UInt:D $num-arrows, UInt:D $n --> UInt:D) {
    up-arrow($m, $num-arrows-1, up-arrow($m, $num-arrows, $n-1));
}
