#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
221-2: Arithmetic Subsequence      Submitted by: Mohammad S Anwar
Given an array of integers, @ints, find the length of the longest
Arithmetic Subsequence in the given array.

A subsequence is an array that can be derived from another array by deleting
some or none elements without changing the order of the remaining elements.

A subsquence is arithmetic if ints[i + 1] - ints[i] are all the same value
(for 0 <= i < ints.length - 1).

Example 1:
Input: @ints = (9, 4, 7, 2, 10)
Output: 3

The longest Arithmetic Subsequence (4, 7, 10) can be derived by deleting 9 and 2.
Example 2:
Input: @ints = (3, 6, 9, 12)
Output: 4

No need to remove any elements, it is already an Arithmetic Subsequence.
Example 3:
Input: @ints = (20, 1, 15, 3, 10, 5, 8)
Output: 4

The longest Arithmetic Subsequence (20, 15, 10, 5) can be derived by deleting 1, 3 and 8.
=end comment

sub longest-arithmetic-subsequence( @in -->Array) {

    return @in.Array if @in.elems < 3;
    my @best = @in[0..1];
    my @candi;
    for ^(@in -2) -> $uno {                     # get first idx
        for $uno^..^(@in-1) -> $dos {           # get second and set sought val
            @candi = @in[$uno], @in[$dos];
            my $delta = @in[$dos] - @in[$uno];
            my $sot = @in[$dos] + $delta;;
            for $dos^..^@in ->$n {              # get n-th, set sot & repeat
                if @in[$n] == $sot {
                    @candi.push: @in[$n];
                    $sot += $delta;
                    @best = @candi if @best.elems < @candi.elems;
                    next;
    }   }   }   }
    @best;
}

my @Test =
   # exp     in                  subseq
    0,      (),                 [,],
    4,      (1,2,3,4,),         [1,2,3,4],
    2,      (1,5,3,4,),         [1,5],
    3,      (9,1,2,3,),         [1,2,3],
    3,      (1,9,2,3,),         [1,2,3],
    3,      (1,2,9,3,),         [1,2,3],
    3,      (1,2,3,9,),         [1,2,3,],
    5,      (1,2,3,4,5),        [1,2,3,4,5],
    3,      (1,0,3,4,5),        [1,3,5],
    2,      (1,2,0,4,5),        [1,2],
    3,      (1,2,3,0,5),        [1,2,3,],
    4,      (1,2,3,4,0),        [1,2,3,4,],
    4,      (0,2,3,4,5),        [2,3,4,5,],
    1,      (2,),               [2,],
    2,      (1,2,),             [1,2,],
    3,      (1,2,3,),           [1,2,3,],
    3,      (3,2,1,),           [3,2,1,],
    3,      (-1,-2,-3,),        [-1,-2,-3,],
    3,      (-1,0,1,),          [-1, 0, 1,],
    3,      (1,0,-1,),          [1, 0, -1,],
    3,      (9,4,7,2,10,0),     [4,7,10,],
    3,      (9,4,7,2,9,0),      [4,2,0,],
    4,      (3,6,9,12,),        [3,6,9,12,],
    4,      (20,1,15,3,10,5,8,), [20,15,10,5,],
;
plan @Test × 2/3;

for @Test -> $exp, @in, @subseq {
    my @got = longest-arithmetic-subsequence(@in);
    ok @subseq ~~ @got, "@subseq[]  <-- @got[]";
    is @got.elems, $exp, "$exp count <- @in.raku()";
}
done-testing;

my @int = (1, 20, 3, 15, 5, 10, 8);

say "\nInput: @ints = @int[]\nOutput: ",
        longest-arithmetic-subsequence(@int).elems;

