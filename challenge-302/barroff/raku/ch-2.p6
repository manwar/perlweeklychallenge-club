#!/usr/bin/env raku

use v6.d;

sub step-by-step(@ints --> Int) {
    my ($xmin, $result) = (0, 0);
    for @ints -> $i {
        $result += $i;
        $xmin = $result if $result < $xmin;
    }

    if $xmin == 0 {
        $result = 1;
    } else {
        $result = 1 - $xmin;
    }

    return $result;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is step-by-step([-3, 2, -3, 4, 2]), 5, 'works for "[-3, 2, -3, 4, 2]"';
    is step-by-step([1, 2]), 1, 'works for "[1, 2]"';
    is step-by-step([1, -2, -3]), 5, 'works for "[1, -2, -3]"';
}

#| Take user provided numbers like 3, 30, 34, 5, 9
multi sub MAIN(*@ints) {
    say step-by-step(@ints);
}
