#!/usr/bin/env raku

use v6.d;

sub lucky-integer(@ints --> Int) {
    my %int-bag = Bag(@ints);
    my @result = grep({ %int-bag{$_} == $_ }, keys %int-bag);
    @result ?? Int(max(@result)) !! -1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is lucky-integer([2, 2, 3, 4]), 2, 'works for "(2, 2, 3, 4)"';
    is lucky-integer([1, 2, 2, 3, 3, 3]), 3, 'works for "(1, 2, 2, 3, 3, 3)"';
    is lucky-integer([1, 1, 1, 3]), -1, 'works for "(1, 1, 1, 3)"';
}

#| Take user provided numbers like 2 2 3 4
multi sub MAIN(*@ints) {
    say lucky-integer(@ints);
}
