#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
354-Task 2: Shift Grid          Submitted by: Mohammad Sajid Anwar
You are given m x n matrix and an integer, $k > 0.
Write a script to shift the given matrix $k times.
Each shift follow the rules:

Rule 1:
Element at grid[i][j] moves to grid[i][j + 1]
This means every element moves one step to the right within its row.

Rule 2:
Element at grid[i][n - 1] moves to grid[i + 1][0]
This handles the last column: elements in the last column of row i wrap to the first column of the next row (i+1).

Rule 3:
Element at grid[m - 1][n - 1] moves to grid[0][0]
This is the bottom-right corner: it wraps to the top-left corner.
=end comment

my @Test;
{
        my \A = Array;
        my \s = 'shape';
    @Test =
        {   k      => 1,
            matrix => [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
            exp    => [[9, 1, 2], [3, 4, 5], [6, 7, 8]],
        },
        {   k      => 1,
            matrix => [[10, 20], [30, 40]],
            exp    => [[40, 10], [20, 30]],
        },
        {   k      => 1,
            matrix => [[1, 2], [3, 4], [5, 6]],
            exp    => [[6, 1], [2, 3], [4, 5]],
        },
        {   k      => 5,
            matrix => [[1, 2, 3], [4, 5, 6]],
            exp    => [[2, 3, 4], [5, 6, 1]],
        },
        {   k      => 1,
            matrix => [1, 2, 3, 4],
            exp    => [4, 1, 2, 3],
        },
    ;
}
plan +@Test;

multi task(     Int:D $shift is copy where * > 0,
                Any   @m where { .[0] ~~ Int:D } -->Array) {
    $shift %= @m.elems;
    return [ flat @m[(*-$shift)..^@m], @m[^(* - $shift)]] ;
}

multi task( Int:D $shift is copy where * > 0, 
            Any   @m  -->Array) {
    die 'Raggedy matrix' unless @m[0] ~~ Array and @m[0] == @m.all;
    my \c   = @m[0].elems;
    my @f   = @m.flat: :hammer;
    return [ ( @f[(*-$shift)..^@f], @f[^(* - $shift)]).flat.rotor(c)».Array ];
}

for @Test -> %t {
    my $in    := %t<matrix>;
    my $exp   := %t<exp>;
    my $shift := %t<k>;
    is task( $shift, $in), $exp,
            "{$exp // $exp.^name()} <- $shift ∘∘ $in.raku()";
}
done-testing;

my  @matrix = [1, 2, 3], [4, 5, 6];
my $k = 4;

say qq{\nInput: @matrix = @matrix.raku()
       \$k = $k
Output: &task( $k, @matrix).raku() };
