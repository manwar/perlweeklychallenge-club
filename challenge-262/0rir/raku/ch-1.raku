#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6d;
use Test;

=begin comment
262-1: Max Positive Negative        Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to return the maximum number of either positive or negative integers in the given array.

Example 1
Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
Output: 4

Count of positive integers: 4
Count of negative integers: 3
Maximum of count of positive and negative integers: 4
Example 2
Input: @ints = (-1, -2, -3, 1)
Output: 3

Count of positive integers: 1
Count of negative integers: 3
Maximum of count of positive and negative integers: 3
Example 3

Count of positive integers: 2
Count of negative integers: 0
Maximum of count of positive and negative integers: 2
=end comment

my @Test =
     (-3, 1, 2, -1, 3, -2, 4),  4,
     (-1, -2, -3, 1),           3,
     (1,2),                     2,
     (-2,2),                    1,
     (-2,),                     1,
     (2,),                      1,
     (1,0,1),                   2,
     (-1,0,0,0,1),              1,
     (1,0,0,0,1),               2,
     (0,0,0,0,0),               0,
     (),                        0,

;
plan @Test ÷ 2;

sub func( @a -->Int) {
    my %h =  @a.classify: { when $_ < 0 { Less }
                            when $_ > 0 { More } }

    for Less, More { %h{$_} = %h{$_} :exists  ?? %h{$_}.elems !! 0 }

    %h{Less} max %h{More}
}

for @Test -> @in, $exp {
    is func(@in), $exp, "$exp <- @in.sort()";
}
done-testing;

my @in = -3, 1, 2, -1, 3, -2, 4;
say "\nInput: @in = @in.raku()\nOutput: &func(@in)"

