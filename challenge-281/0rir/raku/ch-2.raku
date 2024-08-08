#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent;
use Test;

use Chess;

=begin comment

281-2: Knight’s Move        Submitted by: Peter Campbell Smith
Restated
Write a script which takes a knight's starting position and its ending
position, in algebraic notation, and calculates the least number of
moves required.

Example 1
Input: $start = 'g2', $end = 'a8'
Ouput: 4

g2 -> e3 -> d5 -> c7 -> a8
Example 2
Input: $start = 'g2', $end = 'h2'
Ouput: 3

g2 -> e3 -> f1 -> h2

=end comment

my @Test =
    # point point moves
    'g2', 'a1', 3,
    'g2', 'h1', 4,
    'g2', 'a8', 4,
    'g2', 'h8', 3,
    'g2', 'h2', 3,

    'a1', 'a2', 3,  'a1', 'a3', 2,  'a1', 'a4', 3,  'a1', 'a5', 2,
    'a1', 'a6', 3,  'a1', 'a7', 4,  'a1', 'a8', 5,
    'a1', 'b1', 3,  'a1', 'b2', 4,  'a1', 'b3', 1,  'a1', 'b4', 2,
    'a1', 'b5', 3,  'a1', 'b6', 4,  'a1', 'b7', 3,  'a1', 'b8', 4,
    'a1', 'c1', 2,  'a1', 'c2', 1,  'a1', 'c3', 4,  'a1', 'c4', 3,
    'a1', 'c5', 2,  'a1', 'c6', 3,  'a1', 'c7', 4,  'a1', 'c8', 5,
    'a1', 'd1', 3,  'a1', 'd2', 2,  'a1', 'd3', 3,  'a1', 'd4', 2,
    'a1', 'd5', 3,  'a1', 'd6', 4,  'a1', 'd7', 3,  'a1', 'd8', 4,
    'a1', 'e1', 2,  'a1', 'e2', 3,  'a1', 'e3', 2,  'a1', 'e4', 3,
    'a1', 'e5', 4,  'a1', 'e6', 3,  'a1', 'e7', 4,  'a1', 'e8', 5,
    'a1', 'f1', 3,  'a1', 'f2', 4,  'a1', 'f3', 3,  'a1', 'f4', 4,
    'a1', 'f5', 3,  'a1', 'f6', 4,  'a1', 'f7', 5,  'a1', 'f8', 4,
    'a1', 'g1', 4,  'a1', 'g2', 3,  'a1', 'g3', 4,  'a1', 'g4', 3,
    'a1', 'g5', 4,  'a1', 'g6', 5,  'a1', 'g7', 4,  'a1', 'g8', 5,
    'a1', 'h1', 5,  'a1', 'h2', 4,  'a1', 'h3', 5,  'a1', 'h4', 4,
    'a1', 'h5', 5,  'a1', 'h6', 4,  'a1', 'h7', 5,  'a1', 'h8', 6,
;
plan 2 × @Test ÷ 3;

my @corner = [ 0,7,56,63];

# Find the dog leg twixt two squares.
sub Δ( Int $a, Int $b --> Array) is pure {
    (   ($a div 8 - $b div 8).abs,          # rank delta
        ($a  %  8 - $b  %  8).abs,          # file delta
    ).sort.Array;
}

my @raw-dog-leg-data = [0, 1, 3],  [0, 2, 2],  [0, 3, 3],  [0, 4, 2], 
            [0, 5, 3],  [0, 6, 4],  [0, 7, 5],

        [1, 1, 2],                                      # corner case 4
            [1, 2, 1],  [1, 3, 2],  [1, 4, 3],  [1, 5, 4],
            [1, 6, 3],  [1, 7, 4],

        [2, 2, 4],  [2, 3, 3],  [2, 4, 2],  [2, 5, 3],  [2, 6, 4],  [2, 7, 5],
        [3, 3, 2],  [3, 4, 3],  [3, 5, 4],  [3, 6, 3],  [3, 7, 4],
        [4, 4, 4],  [4, 5, 3],  [4, 6, 4],  [4, 7, 5],
        [5, 5, 4],  [5, 6, 5],  [5, 7, 4],
        [6, 6, 4],  [6, 7, 5],
        [7, 7, 6];

my %Δ2N-ct{Int};   # Map from dog leg to  N move ct.

for @raw-dog-leg-data -> @a { %Δ2N-ct{ @a[0] }{@a[1]} = @a[2] }

# Knight move count to traverse a dogleg on the board.
sub N-sq2sq-ct( Int $a, Int $b -->Int ) is pure {
    my @leg = Δ( $a, $b);
    die 'There is a compulsion to move' if @leg ~~ [0, 0];  #explicate intent?
    return 4 if @leg ~~ [1,1] and so [$a, $b].any == @corner.any;
    return    %Δ2N-ct{ @leg[0]}{@leg[1] }
}

# Return move count for Knight to get from one named sq to another.
sub task( $a, $b -->Int) is pure {
    N-sq2sq-ct( $a.&algebraic2sq, $b.&algebraic2sq);
}

for @Test -> $a, $b, $exp {
    is task($a, $b), $exp, "$exp <- $a ∘∘ $b";
    is task($b, $a), $exp, "$exp <- $b ∘∘ $a";
}
done-testing;

my ($start, $end ) = 'g2', 'h1';

say "\nInput: \$start = $start, \$end = $end"
  ~ "\nOutput: &task($end,$start)";
