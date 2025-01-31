#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 2: Last Element
Submitted by: Mohammad Sajid Anwar
You are given a array of integers, @ints.

Write a script to play a game where you pick two biggest integers in the given array, say x and y. Then do the following:

a) if x == y then remove both from the given array
b) if x != y then remove x and replace y with (y - x)
At the end of the game, there is at most one element left.

Return the last element if found otherwise return 0.

Example 1
Input: @ints = (3, 8, 5, 2, 9, 2)
Output: 1

Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
Step 2: pick 3 and 5 => (2, 2, 1, 2)
Step 3: pick 2 and 1 => (1, 2, 2)
Step 4: pick 2 and 1 => (1, 2)
Step 5: pick 1 and 2 => (1)
Example 2
Input: @ints = (3, 2, 5)
Output: 0

Step 1: pick 3 and 5 => (2, 2)
Step 2: pick 2 and 2 => ()
=end comment

=begin comment
    Although the game cannot generate a zed, it is a possible ending
    value.  So I am maintaining the difference between empty and 0.
=end comment


my @Test =
    Int,    ()».Int,
    0,      (0,)».Int,
    3,      (3,)».Int,
    Int,     (0,0)».Int,
    Int,    ( -1, -1)».Int,
    0,      (0,0,0)».Int,
    Int,    (3, 2, 5)».Int,
    Int,    (3,3,3,3)».Int,
    1,      (1,1, 39 ,40)».Int,
    3,      (3,3,3,3,3)».Int,
    1,      (3, 8, 5, 2, 9, 2)».Int,
    7,      (0, 0, 0, 0, 0, 7)».Int,
;
plan @Test ÷ 2;


only task( @a --> Int) {
    my $h = @a.BagHash;
    my Int $max;
    my Int $max-jr;

    loop {
        return Int if not $h;                   # ().BagHash

                 # Handle the max level.
        $max = $h.keys.max;
        next if $h{$max} :delete  %% 2;         # Just delete it.

        return $max if not $h;                  # No next level.

        $max-jr = $h.keys.max;                  # Calc & store difference.
        -- $h{ $max-jr};
        $h.add( $max - $max-jr );
    }
}

for @Test -> $exp, @in {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()"
}
done-testing;

my Int @int =  3, 8, 5, 2, 9, 1;
say "\nInput: @int = @int[]\nOutput: ", task(@int) // 0;

