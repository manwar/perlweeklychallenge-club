#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
258-2: Sum of Values         Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @int and an integer $k.

Write a script to find the sum of values whose index binary representation has exactly $k number of 1-bit set.

Example 1
Input: @ints = (2, 5, 9, 11, 3), $k = 1
Output: 17

Binary representation of index 0 = 0
Binary representation of index 1 = 1
Binary representation of index 2 = 10
Binary representation of index 3 = 11
Binary representation of index 4 = 100

So the indices 1, 2 and 4 have total one 1-bit sets.
Therefore the sum, $ints[1] + $ints[2] + $ints[4] = 17
Example 2
Input: @ints = (2, 5, 9, 11, 3), $k = 2
Output: 11
Example 3
Input: @ints = (2, 5, 9, 11, 3), $k = 0
Output: 2

=end comment

my @Test =
    #  @int            k      exp
    (2, 5, 9, 11, 3),   1,      17,
    (2, 5, 9, 11, 3),   2,      11,
    (2, 5, 9, 11, 3),   0,      2,
    (2, 5, 9, 11, 3),   3,      0,
;

plan @Test ÷ 3;

multi func( $k where * == 0, @a ) { @a[0] }

multi func( $k, @a ) {
    [+] @a[  ^@a .grep( $k == *.base(2).comb.grep('1'))  ]; 
}

for @Test -> @in, $k, $exp {
    is func($k, @in), $exp, "$exp\t<- $k K\t@in[]";
}

done-testing;
my @int = ( 0..25);
my $k = 4;

say "\nInput: @int = @int.raku(), \$k = $k\nOutput: &func($k, @int)";

exit;

