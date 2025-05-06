#!/usr/bin/env raku

use v6.d;

sub minimum-common(@array_1, @array_2 --> Int) {
    my %intersection = (Set(@array_1) (&) Set(@array_2));
    return %intersection ?? min(%intersection.keys).Int !! -1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is minimum-common([1, 2, 3, 4], [3, 4, 5, 6]), 3,
        'works for "[1, 2, 3, 4], [3, 4, 5, 6]"';
    is minimum-common([1, 2, 3], [2, 4]), 2, 'works for "[1, 2, 3], [2, 4]"';
    is minimum-common([1, 2, 3, 4], [5, 6, 7, 8]), -1,
        'works for "[1, 2, 3, 4], [5, 6, 7, 8]"';
}
