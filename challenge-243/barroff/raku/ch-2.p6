#!/usr/bin/env raku

sub floor-sum(@nums where all(@nums) ≥ 1 --> Int) {
    sum(map({ $_[0] div $_[1] + $_[1] div $_[0] }, combinations(@nums, 2))) + @nums.elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is floor-sum([2, 5, 9]), 10, 'Works for (2, 5, 9)';
    is floor-sum([7, 7, 7, 7, 7, 7, 7]), 49, 'Works for (7, 7, 7, 7, 7, 7, 7)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(Int @ints) {
    my Int @nums = @ints;
    say floor-sum(@nums);
}
