#!/usr/bin/env raku

use Test;

is( binary-flip(5), 2, "Example 1" );
is( binary-flip(4), 3, "Example 2" );
is( binary-flip(6), 1, "Example 3" );
is( binary-flip(7), 0, "Example [7 ~= 0b111]" );

sub binary-flip(Int $n --> Int) {
    return $n +^ ( -1 + 2** ( $n + 1 ).log2.ceiling );
}
