#!/usr/bin/env raku
subset Monotonic where { [≥] |$_ or [≤] |$_ };

multi monotonic-array ( +@a ) { @a ~~ Monotonic }

multi MAIN (Bool :test($)!) {
    use Test;
    is monotonic-array(1,2,2,3), True;
    is monotonic-array(1,3,2),   False;
    is monotonic-array(6,5,5,4), True;
    done-testing;
}

multi MAIN (+@nums) {
    say +monotonic-array @nums
}
