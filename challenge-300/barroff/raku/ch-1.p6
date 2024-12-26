#!/usr/bin/env raku

use v6.d;

sub is-beautiful(Int $n, Int $i --> Bool) {
    $n mod $i == 0 or $i mod $n == 0;
}

sub check-arrangement(@arrangement --> Bool) {
    so True == all(map({ is-beautiful(@arrangement[$_], $_ + 1) }, ^@arrangement.elems));
}

sub beautiful-arrangement(Int $int --> Int) {
  permutations(1..$int).race.grep({ check-arrangement($_) }).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is beautiful-arrangement(2), 2, 'works for "$int == 2"';
    is beautiful-arrangement(1), 1, 'works for "$int == 1"';
    is beautiful-arrangement(10), 700, 'works for "$int == 10"';
}

#| Take user provided number like 10
multi sub MAIN(Int $int) {
    say beautiful-arrangement($int);
}
