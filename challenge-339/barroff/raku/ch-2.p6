#!/usr/bin/env raku

use v6.d;

sub peak-point(@gain --> Int) {
    my Int $mg = 0;
    my Int $current = 0;
    for @gain -> $i {
        $current += $i;
        $mg = $current if $current > $mg;
    }
    return $mg;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is peak-point([-5, 1, 5, -9, 2]), 1, 'works for [-5, 1, 5, -9, 2]';
    is peak-point([10, 10, 10, -25]), 30, 'works for [10, 10, 10, -25]';
    is peak-point([3, -4, 2, 5, -6, 1]), 6, 'works for [3, -4, 2, 5, -6, 1]';
    is peak-point([-1, -2, -3, -4]), 0, 'works for [-1, -2, -3, -4]';
    is peak-point([-10, 15, 5]), 10, 'works for [-10, 15, 5]';
}

#| Take user provided numbers 5 9 3 4 6
multi sub MAIN(*@gain) {
    say peak-point(@gain);
}
