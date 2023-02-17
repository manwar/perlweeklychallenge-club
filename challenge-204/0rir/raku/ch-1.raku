#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ « ␤ » ∴
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
204-1: Monotonic Array              Submitted by: Mohammad S Anwar
Given an array of integers, find if the given array is Monotonic.
Print 1 if it is otherwise 0.

An array is Monotonic if it is either monotone increasing or decreasing.

Monotone increasing: for i <= j , nums[i] <= nums[j]
Monotone decreasing: for i <= j , nums[i] >= nums[j]

Example 1
Input: @nums = (1,2,2,3)
Output: 1
Example 2
Input: @nums (1,3,2)
Output: 0
Example 3
Input: @nums = (6,5,5,4)
Output: 1
=end comment

my @Test =
    (Empty) =>   Bool,
    (1,2,2,3) => True,
    (1,3,2)   => False,
    (6,5,5,4) => True,
;

multi monotonic( Empty ) { Bool }
multi monotonic( $list --> Bool) {
    my $l = $list.sort.List;
    $list ~~ $l or $list ~~ $l.reverse;
}

plan +@Test;
for @Test -> ( :key($in), :value($exp)) {
    is monotonic($in), $exp, "$in.raku() -> monotonic $exp.gist()";
}
done-testing;


print "\n";
my @num = (1,2,3,4,5,6,7,8,9,10,11,11,11,1,12,13,14,15,15,15,15,16,17,19),
          (1,2,3,4,5,6,7,8,9,10,11,11,11,12,13,14,15,15,15,15,16,17,19);

for 0..^@num {
say "Input: @num = @num[$_]
Output: &monotonic(@num[$_]).Int()";
}
