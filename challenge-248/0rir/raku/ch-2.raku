#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
248-2: Submatrix Sum        Submitted by: Jorg Sommrey

You are given a NxM matrix A of integers.  Write a script to construct a
(N-1)x(M-1) matrix B having elements that are the sum over the 2x2
submatrices of A, b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]

Example 1
Input: $a = [
              [1,  2,  3,  4],
              [5,  6,  7,  8],
              [9, 10, 11, 12]
            ]

Output: $b = [
               [14, 18, 22],
               [30, 34, 38]
             ]
Example 2
Input: $a = [
              [1, 0, 0, 0],
              [0, 1, 0, 0],
              [0, 0, 1, 0],
              [0, 0, 0, 1]
            ]

Output: $b = [
               [2, 1, 0],
               [1, 2, 1],
               [0, 1, 2]
             ]
=end comment

my @Test =
    [ [ 1, 2], [3,4] ],
        [10,],
    [ [ 1, 2, 3], [3,4,5] ],
        [10,14],
    [ [ 1, 2, 3,], [3,4,5,], [21,22,23] ],
        [[10,14], [50,54]],
    [ [1,  2,  3,  4], [5,  6,  7,  8], [9, 10, 11, 12],],
        [ [14, 18, 22], [30, 34, 38], ],
    [ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1], ],
        [ [2, 1, 0], [1, 2, 1], [0, 1, 2], ],
;
my @Die =
    [,],
    [[1,],],
    [[1,],[,],],
    [[,],[2,],],
    [[1,2,3],],
    [[1,],[2,],[3,],],
;

plan +@Die + @Test ÷ 2;

sub submatrix-sum( @m is copy --> Array) {
    die 'matrix too short' unless @m.elems > 1;
    die 'matrix too skinny' unless @m[0].elems > 1;
    die 'ill-formed matrix' unless @m[0.. *-1]».elems.all == @m[0].elems; 
    my @ret;
    for ^@m.end -> \i {
        for ^@m[i].end -> \j {
            @ret[i;j] = [+] @m[i;j], @m[i+1;j], @m[i;j+1], @m[i+1;j+1];
        }
    }
    @ret;
}

for @Test -> @in, @exp {
    is submatrix-sum(@in), @exp, "@exp[] <- @in[]";
}
for @Die -> @in {
    dies-ok { submatrix-sum(@in)}, "die on @in.raku()";
}
done-testing;

sub display-matrix( $prefix, @matrix -->Str) {
    my $ret = "$prefix [\n";
    my $shift = $prefix.chars;
    for @matrix -> @r {
        $ret ~= ' ' x ($shift + 3) ~ @r.raku() ~ "\n";
    }
    $ret ~= ' ' x $shift ~ "]\n";
    $ret;
}

my @a = [ [ 1, 2, 3,], [3,4,5,], [21,22,23] ];
say "\n", display-matrix 'Input: $a = ', @a;
say display-matrix 'Output: $b = ', submatrix-sum( @a);;
exit;
