#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
323-Task 1: Increment Decrement     Submitted by: Mohammad Sajid Anwar
You are given a list of operations.
Write a script to return the final value after performing the given operations in order. The initial value is always 0.

Possible Operations:
++x or x++: increment by 1
--x or x--: decrement by 1

Example 1
Input: @operations = ("--x", "x++", "x++")
Output: 1

Operation "--x" =>  0 - 1 => -1
Operation "x++" => -1 + 1 =>  0
Operation "x++" =>  0 + 1 =>  1

Example 2
Input: @operations = ("x++", "++x", "x++")
Output: 3

Example 3
Input: @operations = ("x++", "++x", "--x", "x--")
Output: 0

Operation "x++" => 0 + 1 => 1
Operation "++x" => 1 + 1 => 2
Operation "--x" => 2 - 1 => 1
Operation "x--" => 1 - 1 => 0
=end comment

my @Test =
    # op-strings                    exp
    ("x++",),                       1,
    ("--x",),                      -1,
    ("--x", "x++", "x++"),          1,
    ("x++", "++x", "x++"),          3,
    ("x++", "++x", "--x", "x--"),   0,
;
plan +@Test;

#       trustfully
sub task( @expr, $seed = 0 -->Int) {
  $seed + @expr - 2 × @expr.grep( *.contains: '-');
}

for @Test -> @in, $exp is rw {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
    my $seed = 10;
    my $ex = $exp + $seed;
    is task( @in, $seed), $ex, "{$ex // $ex.^name()} <- @in.raku() ∘∘ $seed";
}
done-testing;

my @op = ("x++", "++x", "--x", "x--");

say qq{\nInput: @operations = @op.raku()\nOutput: }, task @op;

