#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent;
use Test;

use Chess;

=begin comment
281-1: Check Color      Submitted by: Mohammad Sajid Anwar
Restated
You are given coordinates, a string that represents the coordinates of a
square of the chessboard using the standard algebraic naming,  Looking at
the board from the  white player's side  and  with a dark square nearest
at white's left, the files (columns ) are named, from left to right,
'a' to 'h', and the ranks (rows) are numbered, from nearest to farthest,
'1' to '8'.  So the white player's left hand corner is 'a1' and blacks's
is 'h8'.

Return true if the square is light, and false if the square is dark.

Example 1
Input: $coordinates = "d3"
Output: true
Example 2
Input: $coordinates = "g5"
Output: false
Example 3
Input: $coordinates = "e6"
Output: true

=end comment

my @Test =
    # @input                      $exp
    [< a1 a3 a5 a7 b2 b4 b6 b8
       c1 c3 c5 c7 d2 d4 d6 d8
       e1 e3 e5 e7 f2 f4 f6 f8
       g1 g3 g5 g7 h2 h4 h6 h8 >], False,

    [< a2 a4 a6 a8 b1 b3 b5 b7
       c2 c4 c6 c8 d1 d3 d5 d7
       e2 e4 e6 e8 f1 f3 f5 f7
       g2 g4 g6 g8 h1 h3 h5 h7 >], True,
;
plan 192; 

sub task( $a) is pure {
    so ( %algebraic2sq{$a} div 8 + %algebraic2sq{$a} % 8 )  % 2
}

my %light-alge =
    < a2 a4 a6 a8   b1 b3 b5 b7   c2 c4 c6 c8   d1 d3 d5 d7
      e2 e4 e6 e8   f1 f3 f5 f7   g2 g4 g6 g8   h1 h3 h5 h7 >
    Z[=>] True xx 32;

sub task1( Str $a) is pure { %light-alge{$a} or False }

sub not-task( Int $sq) is pure {
    so ( $sq div 8 + $sq % 8 )  % 2
}
for @Test -> @in, $exp {
    for @in -> $in {
         is task($in), $exp, "$exp <- $in";
         is task1($in), $exp, "$exp <- $in";
         is not-task(algebraic2sq($in)), $exp, "$exp <- $in";
    }
}

done-testing;

my $coordinates = 'g7';
say qq{\nInput: \$coordinates = "$coordinates"\nOutput: &task1($coordinates)};


=finish

use Bench; my $b = Bench.new;
my $sq = 63,
$b.timethese( 64000, {
    alge-mod-mod => { $coordinates.&task  },  
    mod-mod      => { $sq.&not-task       }, 
    alge-lookup  => { $coordinates.&task1 },
});
