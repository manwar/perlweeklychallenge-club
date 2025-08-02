#!/usr/bin/env raku

use v6.d;

sub maximum-count(@ints --> Int) {
    my $p-digits = grep({ $_ > 0 }, @ints).elems;
    my $n-digits = grep({ $_ < 0 }, @ints).elems;
    return max($p-digits, $n-digits);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is maximum-count([-3, -2, -1, 1, 2, 3]), 3,
        'works for "[-3, -2, -1, 1, 2, 3]"';
    is maximum-count([-2, -1, 0, 0, 1]), 2, 'works for "[-2, -1, 0, 0, 1]"';
    is maximum-count([1, 2, 3, 4]), 4, 'works for "[1, 2, 3, 4]"';
}

#| Take user provided numbers like 3, 30, 34, 5, 9
multi sub MAIN(*@ints) {
    say maximum-count(@ints);
}
