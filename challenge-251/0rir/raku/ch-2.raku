#!/home/rir/Repo/rakudo/install/bin/raku
##!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.e.PREVIEW;
use Math::Matrix;
use Test;

=begin comment
251-2: Lucky Numbers        Submitted by: Mohammad S Anwar
You are given a m x n matrix of distinct numbers.
Write a script to return the lucky number, if there is one, or -1 if not.
A lucky number is an element of the matrix such that it is
the minimum element in its row and maximum in its column.

Example 1
Input: $matrix = [ [ 3,  7,  8],
                   [ 9, 11, 13],
                   [15, 16, 17] ];
Output: 15

15 is the only lucky number since it is the minimum in its row
and the maximum in its column.
Example 2
Input: $matrix = [ [ 1, 10,  4,  2],
                   [ 9,  3,  8,  7],
                   [15, 16, 17, 12] ];
Output: 12
Example 3
Input: $matrix = [ [7 ,8],
                   [1 ,2] ];
Output: 7
=end comment


my @Test =
    -1,  [],
    1,        [ 1, 2, 3 ],
    1,      [ [ 1, 2, 3], ],
    12,     [ [ 1,  10,  4,  2],
              [ 9,  3,  8,  7],
              [15, 16, 17, 12] ],
    15,     [ [ 3,  7,  8],
              [ 9, 11, 13],
              [15, 16, 17] ],
     7,      [ [7 ,8],
               [1 ,2] ],
    -1,     [ [ 1,2,3 ],
              [ 7,5,6 ],
              [ 4,8,9 ], ],
;
plan @Test ÷ 2;

sub ____ (+@list) { gather @list.deepmap: *.take }   # move to Flatland

# is a one-dim array a matrix?
multi the-lucky-number-is( @a where * ~~ Empty) { -1 }
multi the-lucky-number-is( @a where (*.end == 0 and *[0] !~~ Array)) { @a.min }
multi the-lucky-number-is( @a where (*.end == 1 and *[0] ~~ Array)) {
    @a[0].min
}

multi the-lucky-number-is( @a = @Test[1] --> Int) {
    my @w = @a.&____.sort;
    die 'Non-distinct data' unless @w.sort eqv @w.unique.sort;

    my @min = @a.map: *.min;
    my @max = do for 0..^@a[0] -> $col { @a[ 0..^@a ;$col].max; }
    my $ret = @min ∩ @max;
    return -1 if $ret ~~ Set.new();
    $ret.keys[0];
}

for @Test -> $exp, $in {
    is the-lucky-number-is($in), $exp, "$exp <- $in.raku()";
}

done-testing;

exit;

