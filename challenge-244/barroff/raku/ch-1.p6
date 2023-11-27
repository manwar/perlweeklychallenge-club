#!/usr/bin/env raku

sub count-smaller(@nums --> List) {
    my %positions = @nums.sort.kv.reverse.hash;
    %positions{ @nums };
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is count-smaller([8, 1, 2, 2, 3]), (4, 0, 1, 1, 3), 'Works for (8, 1, 2, 2, 3)';
    is count-smaller([6, 5, 4, 8]), (2, 1, 0, 3), 'Works for (6, 5, 4, 8)';
    is count-smaller([2, 2, 2]), (0, 0, 0), 'Works for (2, 2, 2)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(Int @ints) {
    my Int @nums = @ints;
    say count-smaller(@nums);
}
