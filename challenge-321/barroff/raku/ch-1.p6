#!/usr/bin/env raku

use v6.d;

sub distinct-average(@nums where @nums.elems mod 2 == 0 --> Int) {
    my @sorted-nums = @nums.sort;
    Set(
        map(
            { @sorted-nums[$_] + @sorted-nums[* - 1 - $_] },
            0..@nums.elems ÷ 2 - 1
        )
    ).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is distinct-average([1, 2, 4, 3, 5, 6]), 1, 'works for "[1, 2, 4, 3, 5, 6]"';
    is distinct-average([0, 2, 4, 8, 3, 5]), 2, 'works for "[0, 2, 4, 8, 3, 5]"';
    is distinct-average([7, 3, 1, 0, 5, 9]), 2, 'works for "[7, 3, 1, 0, 5, 9]"';
}

#| Take user provided numbers like 3, 30, 34, 5, 9
multi sub MAIN(*@ints) {
    say distinct-average(@ints);
}
