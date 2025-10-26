#!/usr/bin/env raku

use v6.d;

sub array-formation(@source, @target --> Bool) {
    my Str $targetString = @target.Str;
    return so map({ $_.Str }, @source.permutations).any eq $targetString;
}

#| Run test cases
sub MAIN('test') {
    use Test;
    plan 5;

    is array-formation(([2,3], [1], [4]), (1, 2, 3, 4)), True,
        'works for "(2,3], [1], [4])"';
    is array-formation(([1,3], [2,4]), (1, 2, 3, 4)), False,
        'works for "([1,3], [2,4])"';
    is array-formation(([9,1], [5,8], [2]), (5, 8, 2, 9, 1)), True,
        'works for "([9,1], [5,8], [2])"';
    is array-formation(([1], [3]), (1, 2, 3)), False, 'works for "([1], [3])"';
    is array-formation(([7,4,6]), (7, 4, 6)), True, 'works for "([7,4,6])"';
}
