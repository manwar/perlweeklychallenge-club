#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
304-1: Arrange Binary        Submitted by: Mohammad Sajid Anwar
You are given a list of binary digits (0 and 1) and a positive integer, $n.

Write a script to return true if you can re-arrange the list by replacing at least $n digits with 1 in the given list so that no two consecutive digits are 1 otherwise return false.

Example 1
Input: @digits = (1, 0, 0, 0, 1), $n = 1
Output: true

Re-arranged list: (1, 0, 1, 0, 1)
Example 2
Input: @digits = (1, 0, 0, 0, 1), $n = 2
Output: false
=end comment

=begin comment
   I am accepting arrays with heading zeds, because binary numbers are
   sometimes presented like sized bit fields.
=end comment

my @Test =
    # ct   in
    0,  (),
    1,  <0      >».Int,
    0,  <1      >».Int,
    1,  <0 0    >».Int,
    0,  <0 1    >».Int,
    0,  <1 0    >».Int,
    0,  <1 1    >».Int,
    2,  <0 0 0  >».Int,
    1,  <1 0 0  >».Int,
    0,  <0 1 0  >».Int,
    1,  <0 0 1  >».Int,
    0,  <1 1 0  >».Int,
    0,  <1 0 1  >».Int,
    0,  <0 1 1  >».Int,
    0,  <1 1 1  >».Int,
    2,  <0 0 0 0>».Int,
    1,  <0 0 0 1>».Int,
    1,  <0 0 1 0>».Int,
    1,  <0 0 1 1>».Int,
    1,  <0 1 0 0>».Int,
    0,  <0 1 0 1>».Int,
    0,  <0 1 1 0>».Int,
    0,  <0 1 1 1>».Int,
    0,  <1 0 0 1>».Int,
    0,  <1 0 1 0>».Int,
    1,  <1 1 0 0>».Int,
    0,  <1 1 0 1>».Int,
    0,  <1 1 1 0>».Int,
    0,  <1 1 1 1>».Int,
    1,  (1, 0, 0, 0, 1),
    2,  (1, 0, 0, 0, 0, 0, 1),
    2,  <1 0 0 0 0       1     0 0 0 1 0 0 1 >».Int,
    3,  <1 0 0 0 0 0     1     0 0 0 1 0 0 1 >».Int,
    3,  <1 0 0 0 0 0 0   1 1   0 0 0 1 0 0 1 >».Int,
    4,  <1 0 0 0 0 0 0 0 1 1 1 0 0 0 1 0 0 1 >».Int,
    3,  <            0 0 1 1 1 0 0 0 1 0 0   >».Int,
    4,  <  0 0 0 0 0 0 0 1 1 1 0 0 0 1 0 0 1 >».Int,
    5,  <  0 0 0 0 0 0 0 1 1 1 0 0 0 1 0 0 0 >».Int,
;
plan @Test ÷ 2;

sub task( @in, $count -->Bool) {    count( @in) ≥ $count; }

multi count( @a where @a ≤  3 -->Int) {
    given @a {
        when [0]     { 1 }
        when [0,0]   { 1 }
        when [1,0,0] { 1 }
        when [0,0,1] { 1 }
        when [0,0,0] { 2 }
        default      { 0 }
    }
}

multi count( @a is copy --> Int) {
    my Int $ret = 0;
    my $r = 0..2;
                    # Handle 0,0 at head and at tail, to … 
    if @a[0,   1   ] ~~ [0,0] { @a[0   ] = 1; ++$ret }
    if @a[@a-2,@a-1] ~~ [0,0] { @a[@a-1] = 1; ++$ret }
    while $r.max < @a  {
        if  @a[@$r] ~~ [0,0,0] {
                    # … avoid changing the middle elem in usual-case triplets.
            ++$ret,
            $r += 2,
            next;
        }
        $r += 1;
    }
    $ret;
}

for @Test -> $exp, @in {
   is count( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @bit = (0,0,1,0,0,0,1,0,0);
my $n = 3;
say "\nInput: @bit = @bit.raku(), \$n = $n\nOutput: { task @bit, $n}";

