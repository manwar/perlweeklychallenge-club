#!/usr/bin/env raku

use v6.d;

sub friday_13th(UInt:D $year --> Int:D) {
    grep({ $_.day-of-week == 5 }, map({ Date.new($year, $_, 13)}, 1..12)).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 1;

    is friday_13th(2023), 2, 'works for 2023';
}

#| Take user provided year like 2023
multi sub MAIN(UInt $number) {
    say friday_13th($number);
}
