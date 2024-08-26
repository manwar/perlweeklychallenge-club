#!/usr/bin/env raku

use v6.d;

sub unique-number(@ints --> Int) {
    my %int-bag = Bag(@ints);
    Int(grep({ %int-bag{$_} == 1 }, %int-bag.keys)[0]);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is unique-number([3, 3, 1]), 1, 'works for "(3, 3, 1)"';
    is unique-number([3, 2, 4, 2, 4]), 3, 'works for "(3, 2, 4, 2, 4)"';
    is unique-number([1]), 1, 'works for "(1)"';
    is unique-number([4, 3, 1, 1, 1, 4]), 3, 'works for "(4, 3, 1, 1, 1, 4)"';
}

#| Take user provided numbers like 4 3 1 1 1 4
multi sub MAIN(*@ints) {
    say unique-number(@ints);
}
