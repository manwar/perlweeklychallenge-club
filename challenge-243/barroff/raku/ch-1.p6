#!/usr/bin/env raku

sub reverse-pairs(@nums --> Int) {
    grep({ $_[0] > 2 * $_[1] }, combinations(@nums, 2)).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is reverse-pairs([1, 3, 2, 3, 1]), 2, 'Works for (1, 3, 2, 3, 1)';
    is reverse-pairs([2, 4, 3, 5, 1]), 3, 'Works for (2, 4, 3, 5, 1)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(Int @ints) {
    my Int @nums = @ints;
    say reverse-pairs(@nums);
}
