#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;

=begin comment

Edited for space.
338- Task 2: Max Distance       Submitted by: Mohammad Sajid Anwar

You are given two integer arrays, @arr1 and @arr2.
Write a script to find the maximum difference between any pair of values from both arrays.

Example 1
Input: @arr1 = (4, 5, 7)
       @arr2 = (9, 1, 3, 4)
Output: 6

With element $arr1[0] = 4
| 4 - 9 | = 5
| 4 - 1 | = 3
| 4 - 3 | = 1
| 4 - 4 | = 0
max distance = 5

With element $arr1[1] = 5
| 5 - 9 | = 4
| 5 - 1 | = 4
| 5 - 3 | = 2
| 5 - 4 | = 1
max distance = 4

With element $arr1[2] = 7
| 7 - 9 | = 2
| 7 - 1 | = 6
| 7 - 3 | = 4
| 7 - 4 | = 4
max distance = 6

max (5, 6, 6) = 6

=end comment

my @Test =
    (4, 5, 7),          (9, 1, 3, 4),           6,
    (2, 3, 5, 4),       (3, 2, 5, 5, 8, 7),     6,
    (2, 1, 11, 3),      (2, 5, 10, 2),          9,
    (1, 2, 3),          (3, 2, 1),              2,
    (1, 0, 2, 3),       (5, 0),                 5,
;

plan +@Test ÷ 3;

sub task( @a, @b -->Int) {
   max max(@a) - min( @b),  max(@b) - min( @a); 
}

for @Test -> @i, @n, $exp {
    is task( @i, @n), $exp, "{$exp // $exp.^name()} <- @i.raku(), @n.raku()";
}
done-testing;

my @arr1 = 1, 0, 2, 3;
my @arr2 = 5, 0;
say "\nInput: @arr1 = (@arr1.raku())\n       @arr2 = (@arr2.raku())\n"
  ~ "Output: ", task( @arr1, @arr2);

