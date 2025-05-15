#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 1: Distinct Average    Submitted by: Mohammad Sajid Anwar
   [edited]
You are given an array of numbers with even length.

Write a script to return the count of distinct average. The average is 
calculated, by repeatedly, removing the minimum and the maximum, then average of the two.  See notes to examples.

Example 1
Input: @nums = (1, 2, 4, 3, 5, 6)
Output: 1

Step 1: Min = 1, Max = 6, Avg = 3.5
Step 2: Min = 2, Max = 5, Avg = 3.5
Step 3: Min = 3, Max = 4, Avg = 3.5

The count of distinct average is 1.

Example 2
Input: @nums = (0, 2, 4, 8, 3, 5)
Output: 2

Example 3
Input: @nums = (7, 3, 1, 0, 5, 9)
Output: 2

=end comment

my @Test =
    # in                exp
    (1, 2, 4, 3, 5, 6),     1,
    (0, 2, 4, 8, 3, 5),     2,
    (7, 3, 1, 0, 5, 9),     2,
    (1,1),                  1,
    (2,1),                  1,
;
plan @Test ÷ 2;

sub task( $a is copy -->Int) {
    $a = $a.sort;
    my \i = $a.end div 2;
    ( [Z+] $a[0..i],
           $a[$a.end … i+1]
    ).unique.elems;
}

for @Test -> @in, $exp, {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @num = (7, 3, 1, 0, 5, 9);

say "\nInput: @nums = @num.raku()\nOutput: &task( @num)";

