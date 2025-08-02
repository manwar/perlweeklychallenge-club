#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
260-1: Unique Occurrences           Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.  Write a script to return 1 if
the number of occurrences of each value in the given array is unique or 0
otherwise.

Example 1
Input: @ints = (1,2,2,1,1,3)
Output: 1

The number 1 occurred 3 times.
The number 2 occurred 2 times.
The number 3 occurred 1 time.

All occurrences are unique, therefore the output is 1.
Example 2
Input: @ints = (1,2,3)
Output: 0
Example 3
Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
Output: 1
=end comment

my @Test =
    (1,2,2,1,1,3),              True,
    (1,2,3),                    False,
    (-2,0,1,-2,1,1,0,1,-2,9),   True,
    (0…10000).List,             False,
    (1…100_000, 999_999).List,  False,
    (1 xx 70, 2 xx 71, 3 xx 72, 4 xx 75, 5 xx 76).flat, True;
;

plan @Test ÷ 2;

sub func( $l -->Bool) {
    my $k = $l.Bag.values.sort.List;
    $k eqv $k.unique.List;
}

for @Test -> $in, $exp {
    is func($in), $exp, ($++).Str;
}

done-testing;
my @int = (1 xx 70, 2 xx 71, 3 xx 72, 4 xx 75, 5 xx 76).flat;

say "\nInput: @int = @int[]\nOutput: ", func(@int).Int;



exit;

