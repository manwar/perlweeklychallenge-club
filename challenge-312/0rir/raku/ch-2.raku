#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
312-Task 2: Balls and Boxes
Submitted by: Mohammad Sajid Anwar
There are $n balls of mixed colors: red, blue or green. They are all distributed in 10 boxes labelled 0-9.

You are given a string describing the location of balls.

Write a script to find the number of boxes containing all three colors. Return 0 if none found.

Example 1
Input: $str = "G0B1R2R0B0"
Output: 1

The given string describes there are 5 balls as below:
Box 0: Green(G0), Red(R0), Blue(B0) => 3 balls
Box 1: Blue(B1) => 1 ball
Box 2: Red(R2) => 1 ball
Example 2
Input: $str = "G1R3R6B3G6B1B6R1G3"
Output: 3

The given string describes there are 9 balls as below:
Box 1: Red(R1), Blue(B1), Green(G1) => 3 balls
Box 3: Red(R3), Blue(B3), Green(G3) => 3 balls
Box 6: Red(R6), Blue(B6), Green(G6) => 3 balls
Example 3
Input: $str = "B3B2G1B3"
Output: 0

Box 1: Green(G1) => 1 ball
Box 2: Blue(B2)  => 1 ball
Box 3: Blue(B3)  => 2 balls
=end comment

my @Test =
=begin x
=end x
    "",                     0,
    Str,                  Int,
    "G0B0",                 0,
    "G0",                   0,
    "B3B2G1B3",             0,
    "G0B1R2R0B0",           1,
    "G0B0R0",               1,
    "G1R3R6B3G6B1B6R1G3",   3,
;

plan +@Test;

my @ITEM = < R G B>;
my \Item-ct = +@ITEM;

multi task1( Str:U $s -->Int  ) { Int}
multi task1( Str:D $s -->Int:D) {
    my $ret = 0;
    my $i = Item-ct -1;
    my \fwd-win = $i +1;
    my @a = ($s.comb(2).unique».flip».substr(0,1)).sort;
    while $i < @a {
        when ( @a[$i-@ITEM ^..^ $i ]).all eq  @a[$i] {
                ++ $ret;
                $i += fwd-win;
       }
       ++ $i;
   }
   $ret;
}

multi task2( Str:U $s -->Int  ) { Int}
multi task2( Str:D $s ) {
    my %h = $s.comb(2).unique.classify: *.substr(1,1), :as(*.substr(0,1));
    +%h.values.grep: *.elems == Item-ct;
}


for @Test -> $in, $exp  {
    is task1( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
    is task2( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()"
}
done-testing;

my $str = "G1R3R6B3G6B1B6R1G3G9R7B8" x 10;

say "\nInput: \$str = $str\nOutput: {task2 $str}";

