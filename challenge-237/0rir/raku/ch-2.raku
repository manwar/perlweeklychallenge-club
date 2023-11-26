#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
236-2: Maximise Greatness       Submitted by: Mohammad S Anwar

Given an array of integers, permute the given array such that you get
the maximum possible greatness.

To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length

Example 1
Input: @nums = (1, 3, 5, 2, 1, 3, 1)
Output: 4

One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns 4 greatness as below:
nums[0] < perm[0]
nums[1] < perm[1]
nums[3] < perm[3]
nums[4] < perm[4]

Example 2
Input: @ints = (1, 2, 3, 4)
Output: 3

One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:
nums[0] < perm[0]
nums[1] < perm[1]
nums[2] < perm[2]

=end comment

my @Test =
    (1,),                       0,
    (1,1,1,1),                  0,
    (1,2),                      1,
    (3,2,1),                    2,
    (1,1,2),                    1,
    (1,3,2,4),                  3,
    (1,1,1,2),                  1,
    (1,1,1,1,2),                1,
    (1,1,1,1,2,2),              2,
    (1,1,1,1,2,2,2),            3,
    (1,1,1,1,2,2,2,2),          4,
    (1,1,1,1,2,2,2,2,2),        4,
    (1,1,1,1,2,2,2,2,2,2,2),    4,
    (1,3,5,2,1,3,1),            4,
    (1,1,3,5,2,1,3,1),          4,
    (1,3,5,2,1,3,1,3,3,5),      6,
    (1,3,5,2,1,3,1,3,3,3),      5,
    (1,3,5,2,1,3,1,5,5,5),      6,
    (1,3,5,2,1,3,1,5,5,5,4),    7,
;

plan @Test ÷ 2;

sub func( @in is copy --> Int) {

    return 0 if @in.end == 0;

    my ($head, $tail, $work) = 0, 1, 0;
    @in.=sort;

    while $tail ≤ @in.end {
        if @in[$tail] == @in[$head] {
            ++$tail;
            next;
        }
        ++$tail;
        ++$head;
    }
    $head;
}

for @Test -> @in, $exp {
    is func(@in), $exp, "$exp <- in: @in.sort()";
}
done-testing;
my @int = (1,3,5,2,1,3,1,5,5,5,4).sort;
say "\nInput: @int =  @int.raku()\nOutput: &func( @int)";
exit;

