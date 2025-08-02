#!/usr/bin/env raku

use v6.d;

sub maximum-frequency(@ints --> Int) {
    my %ints-bag = Bag(@ints);
    my $maximum-occurrence = max(values(%ints-bag));
    grep(
        { %ints-bag{$_} == $maximum-occurrence },
        keys(%ints-bag)
    ).elems * $maximum-occurrence;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is maximum-frequency([1, 2, 2, 4, 1, 5]), 4, 'works for [1, 2, 2, 4, 1, 5]';
    is maximum-frequency([1, 2, 3, 4, 5]), 5, 'works for [1, 2, 3, 4, 5]';
}

#| Take user provided number like 1024 512 256 128 64
multi sub MAIN(*@ints) {
    say maximum-frequency(@ints);
}
