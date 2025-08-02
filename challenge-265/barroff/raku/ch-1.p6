#!/usr/bin/env raku

use v6.d;

sub thirtythree-appearance(@ints) {
    my %int-bag = @ints.Bag;
    my $third = @ints.elems ÷ 3;
    my @smallest-appearances = grep({ %int-bag{$_} ≥ $third }, %int-bag.keys);
    return @smallest-appearances.min.Int if @smallest-appearances;
    return Any;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is thirtythree-appearance([1,2,3,3,3,3,4,2]), 3, 'works for (1,2,3,3,3,3,4,2)';
    is thirtythree-appearance([1, 1]), 1, 'works for (1, 1)';
    is thirtythree-appearance([1, 2, 3]), 1, 'works for (1, 2, 3)';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(*@ints) {
    say thirtythree-appearance(@ints);
}
