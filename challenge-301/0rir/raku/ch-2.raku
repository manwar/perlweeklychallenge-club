#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
301-Task 2: Hamming Distance            Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.
Write a script to return the sum of Hamming distances between all the pairs of the integers in the given array of integers.
The Hamming distance between two integers is the number of places in which their binary representations differ.

Example 1

Input: @ints = (4, 14, 2)
Output: 6

Binary representation:
4  => 0100
14 => 1110
2  => 0010

HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6.

Example 2

Input: @ints = (4, 14, 4)
Output: 4

=end comment

=begin interpretation
By the above description, the sign of a number has no significance.
=end interpretation

my @Test =
    # exp   # in
    2,  [1, 2],
    1,  [2, 3],
    6,  [4, 14, 2],
    4,  [4, 14, 4],
;
plan @Test ÷ 2;

sub task( @a is copy --> Int) {
    my Int $ret = 0;
    for @a { $_ = .abs().base(2) }

    for ^@a -> \i {
        my $e = @a[i];
        for i^..^@a -> \j  {
            my $n = @a[j];
            my $excess = $e.chars - $n.chars ;
            if $excess > 0 {
                $e.=substr: $excess;
            } else {
                $excess.=&abs;
                $n.=substr: $excess;
            }
            for $e.comb Z $n.comb -> ($k,$v) {
                ++$ret if $k ≠ $v;
            }
            $ret += $excess;
        }
    }
    $ret;
}

for @Test -> $exp, @in {
    is task(@in), $exp, "$exp <- @in[]";
}
done-testing;

my @int = (4, 14, 4, 7, 111);

say "\nInput: @int = @int.raku()\nOutput: {task @int}";
