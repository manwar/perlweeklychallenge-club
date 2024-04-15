#!/usr/bin/env raku

use v6.d;

sub target-array(@source, @indices where @source.elems == @indices.elems --> Array) {
    return @source if @source.elems ≤ 1;
    my Int:D @target = [@source[0]];
    map({ splice(@target, @indices[$_], 0, @source[$_]) }, 1..@source.elems - 1);
    return @target;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is target-array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]), [0, 4, 1, 3, 2],
        'works for [0, 4, 1, 3, 2]';
    is target-array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]), [0, 1, 2, 3, 4],
        'works for [0, 1, 2, 3, 4]';
    is target-array([1], [0]), [1], 'works for [1]';
}
