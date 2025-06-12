#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 2: Final Price         Submitted by: Mohammad Sajid Anwar
You are given an array of item prices.
Write a script to find out the final price of each items in the given array.

There is a special discount scheme going on. If there’s an item with a lower or equal price later in the list, you get a discount equal to that later price (the first one you find in order).

Example 1
Input: @prices = (8, 4, 6, 2, 3)
Output: (4, 2, 4, 2, 3)

Example 2
Input: @prices = (1, 2, 3, 4, 5)
Output: (1, 2, 3, 4, 5)

Example 3
Input: @prices = (7, 1, 1, 5)
Output: (6, 0, 1, 5)

=end comment

my @Test =
    #   in                  exp
    (8, 4, 6, 2, 3),    (4, 2, 4, 2, 3),
    (1, 2, 3, 4, 5),    (1,2, 3, 4, 5),
    (7, 1, 1, 5),       (6, 0, 1, 5),
;
plan +@Test ÷ 2;

sub task( @l) {
    my @a = @l;
    for 0..^@a.end -> \i {
        @a[i] = @a[i] - (@a[i+1..@a-1].first( * ≤  @a[i]) // 0);
    }
    @a;
}

for @Test -> @in, @exp {
    is task( @in), @exp, "{@exp // @exp.^name()} <- @in.raku()";
}
done-testing;

my @price = 8, 4, 6, 2, 3;

say "\nInput: @price = @price.raku()\nOutput: {task(@price)}";

