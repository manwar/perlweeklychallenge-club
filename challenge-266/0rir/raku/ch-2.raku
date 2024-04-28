#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
266-2: X Matrix         Submitted by: Mohammad Sajid Anwar
You are given a square matrix, $matrix.

Write a script to find if the given matrix is X Matrix.

A square matrix is an X Matrix if all the elements on the main diagonal and antidiagonal are non-zero and everything else are zero.

Example 1
Input: $matrix = [ [1, 0, 0, 2],
                   [0, 3, 4, 0],
                   [0, 5, 6, 0],
                   [7, 0, 0, 1],
                 ]
Output: true

=end comment

my @Dead =  [],     [[,],] ;

my @Test =
    [   [1],       ],               True,
    [   [0],       ],               False,
    [   [1, 1], [2, 2],    ],       True,
    [   [1, 0], [2, 2],    ],       False,
    [   [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9], ],       False,
    [   [1, 0, 3],
        [0, 5, 0],
        [7, 0, 9], ],       True,
    [   [1, 0, 2],
        [0, 3, 0],
        [4, 0, 5], ],       True,
    [   [1, 0, 0, 2],
        [0, 3, 4, 0],
        [0, 5, 6, 0],
        [7, 0, 0, 1], ],    True,
;
plan  2 + +@Test ÷ 2;

multi is-X-matrix( [[],]) { die "what is that" }
multi is-X-matrix( [])    { die "unsatisfying" }
multi is-X-matrix( @a -->Bool:D) {
    my ( $x1,$x2) = 0, @a.end;      # Set up tracking of main diag. loca.
    my @X;
    for @a -> @r {
        @X = ($x1, $x2).squish.sort;
        my @non-zed-loc = @r.grep( :k, * !~~ 0);  # Get all non-zed loca
        return False if +@non-zed-loc ≠  +@X;     # Have wrong count of non-zed
        return False if  @non-zed-loc !~~ @X ;    # Check diag values
        ++ $x1;
        -- $x2;
    }
    return True;
}

for @Test -> @in, $exp {
    is is-X-matrix(@in), $exp, "$exp <- @in.raku()";
}
for @Dead -> @in {
    dies-ok { is-X-matrix @in }, "@in.raku() No numbers";
}


sub display-matrix( $prefix, @matrix -->Str) {
    my $ret = "$prefix [\n";
    my $shift = $prefix.chars;
    for @matrix -> @r {
        $ret ~= ' ' x ($shift + 3) ~ @r.raku() ~ "\n";
    }
    $ret ~= ' ' x $shift ~ "]\n";
    $ret;
}
done-testing;

my @matrix = [ [1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1], ];
say display-matrix( "\nInput: @matrix = ", @matrix);
say "Output: ", is-X-matrix( @matrix);

