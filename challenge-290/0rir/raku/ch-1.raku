#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
290-1: Double Exist         Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.
Write a script to find if there exist two indices $i and $j such that:

1) $i != $j
2) 0 <= ($i, $j) < scalar @ints
3) $ints[$i] == 2 * $ints[$j]
Example 1
Input: @ints = (6, 2, 3, 3)
Output: true

For $i = 0, $j = 2
$ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]
Example 2
Input: @ints = (3, 1, 4, 13)
Output: false
Example 3
Input: @ints = (2, 1, 4, 2)
Output: true

For $i = 2, $j = 3
$ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]
=end comment

my @Test =
    (),                 False,
    (6,),               False,
    (6, 2, 3, 3),       True,
    (3, 1, 4, 13),      False,
    (2, 1, 4, 2),       True,
    (-2, 0, 1, -4, 5),  True,
;
plan @Test ÷ 2;

# True if a or b is the double of the other.
sub x2mate( \a, \b) {
    return True if a × 2 == b or a div 2 == b;
    False;
}

# True if two elements of @a make $rout( \a, \b) so.
multi task( @a where @a ≤  1, $rout ) { False}
multi task( @a,  $rout -->Bool) {
    my @b = @a.sort( { $^a <=> $^b }).squish;
    for ^@b -> \i {
        my $e = @b[i];
        for (i+1)..^@b -> \j {
            return True if $rout( $e, @b[j]);
        }
    }
    return False;
}

for @Test -> @in, $exp {
    is task(@in, &x2mate ), $exp, "$exp <- @in.raku()";
}
my @int =  [1, 7, 17, -5, 3, 4, -2, 11, 0, 1, 17, -4, 5];

say qq{\nInput: @int = @int.raku()\nOutput: &task( @int, &x2mate)};

done-testing;
