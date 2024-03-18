#!/usr/bin/env raku

use v6.d;

sub unique-occurrences(@ints --> Int:D) {
    my @bag_values = Bag(@ints).values;
    @bag_values.unique.elems == @bag_values.elems ?? 1 !! 0;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is unique-occurrences([1,2,2,1,1,3]), 1, 'works for (1,2,2,1,1,3)';
    is unique-occurrences([1,2,3]), 0, 'works for (1,2,3)';
    is unique-occurrences([-2,0,1,-2,1,1,0,1,-2,9]), 1,
        'works for (-2,0,1,-2,1,1,0,1,-2,9)';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(*@ints) {
    say unique-occurrences(@ints);
}

