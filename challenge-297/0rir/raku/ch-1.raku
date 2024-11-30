#!/usr/bin/env  raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
297-1: Contiguous Array             Submitted by: Mohammad Sajid Anwar
You are given an array of binary numbers, @binary.

Write a script to return the maximum length of a contiguous subarray with an equal number of 0 and 1.

Example 1
Input: @binary = (1, 0)
Output: 2

(1, 0) is the longest contiguous subarray with an equal number of 0 and 1.
Example 2
Input: @binary = (0, 1, 0)
Output: 2

(1, 0) or (0, 1) is the longest contiguous subarray with an equal number of 0 and 1.
Example 3
Input: @binary = (0, 0, 0, 0, 0)
Output: 0
Example 4
Input: @binary = (0, 1, 0, 0, 1, 0)
Output: 4
=end comment

my @Test =
     (),                    0,
     (1,),                  0,
     (1, 0),                2,
     (0, 1, 0),             2,
     (0, 0, 0, 0, 0),       0,
     (0, 1, 0, 0, 1, 0),    4,
     ;
plan @Test ÷ 2;

sub task( @a) {
    my $ret = 0;
    for ^@a -> \i {
        ( @a[i..*].join
                ~~ m:ov/
                    .+
                    <?{ my $val = $/.Str.chars;
                        when not $val %% 2 { ; }        # fall out
                        if $/.Str.comb.sum == $val div 2  {
                            $ret max= $val;
                        }
                    }>
                /
        );
    }
    $ret;
}

for @Test -> @in, $exp {
    is task(@in), $exp, "$exp <- @in.raku()";
}

done-testing;

my @binary = (1,0,1).roll(30);

say "Input: @binary = @binary[]\nOutput: {task @binary}";

