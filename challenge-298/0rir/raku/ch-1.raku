#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent.add("lib");
use Matrix;
use Test;


=begin comment
298-Task 1: Maximal Square
Submitted by: Mohammad Sajid Anwar
You are given an m x n binary matrix with 0 and 1 only.

Write a script to find the largest square containing only 1's and return it’s area.

Example 1
Input: @matrix = ([1, 0, 1, 0, 0],
                  [1, 0, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 0, 0, 1, 0])
Output: 4

Two maximal square found with same size marked as 'x':

[1, 0, 1, 0, 0]
[1, 0, x, x, 1]
[1, 1, x, x, 1]
[1, 0, 0, 1, 0]

[1, 0, 1, 0, 0]
[1, 0, 1, x, x]
[1, 1, 1, x, x]
[1, 0, 0, 1, 0]
Example 2
Input: @matrix = ([0, 1],
                  [1, 0])
Output: 1

Two maximal square found with same size marked as 'x':

[0, x]
[1, 0]


[0, 1]
[x, 0]
Example 3
Input: @matrix = ([0])
Output: 0

=end comment

my @Test =
    #exp    in
=begin comment
=end comment
    Int,    [],
    Int,    [[],],
    1,      [   [1,],],
    1,      [   [0,1],],
    1,      [   [0, 1],
                [1, 0],],
    4,      [   [1, 1],
                [1, 1],],
    4,      [   [0, 0],
                [1, 1],
                [1, 1],],
    4,      [   [1, 1],
                [1, 1],
                [0, 0],
            ],
    4,      [   [1, 1, 0],
                [1, 1, 1],
                [0, 1, 1],
            ],
    4,      [   [1, 0, 1, 0, 0],
                [1, 0, 1, 1, 1],
                [1, 1, 1, 1, 1],
                [1, 0, 0, 1, 0],],
    9,      [   [1, 1, 1, 0, 0],
                [1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1],
                [1, 0, 0, 1, 0],],
;
plan @Test ÷ 2;

constant \precious = 1;


multi task( []    ) { Int }
multi task( [[],] ) { Int }
multi task( @m -->Int) {
    my ( $r, $c) = @m.end, @m[0].end;
    my $best = 0;                   # Size of largest square found.
    my $row = 0;
    my $col = 0;
    while $row < @m {
        while $col < @m[0] {
            if @m[$row][$col] ~~ precious {
                my $cot = sq-hunt( @m, $col, $row, $c, $r);
                $best max= $cot;
            }
            if $col <  @m[0].end {
                ++$col;
            } else {
                $col = 0;
                last;
            }
        }
        ++$row;
    }
    return $best² ;
}

sub sq-hunt( @m, \c, \r, \c-end, \r-end -->Int) {
    die unless @m[r][c] ~~ precious;
    my $ret = 0;
    my ($c, $r) = c, r;
    while $r ≤ r-end and $c ≤ c-end {
        if @m[r..$r; c..$c].all ~~ precious {
            ++$ret;
        } else {
            last;
        }
        ++$c;  ++$r;
    }
    $ret;
}

for @Test -> $exp, @in {
    is task(@in), $exp, "$exp.gist() <- @in.raku()";
}

done-testing;

my @matrix =     [[1, 0, 1, 0, 0],
                  [1, 1, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 1, 1, 1, 0]];
print "\n";
matrix-say @matrix;
say "Output: ", task @matrix;
