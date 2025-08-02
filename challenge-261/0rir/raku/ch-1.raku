#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
Task 1: Element Digit Sum
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to evaluate the absolute difference between element and digit sum of the given array.

Example 1
Input: @ints = (1,2,3,45)
Output: 36

Element Sum: 1 + 2 + 3 + 45 = 51
Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
Absolute Difference: | 51 - 15 | = 36
Example 2
Input: @ints = (1,12,3)
Output: 9

Element Sum: 1 + 12 + 3 = 16
Digit Sum: 1 + 1 + 2 + 3 = 7
Absolute Difference: | 16 - 7 | = 9
Example 3
Input: @ints = (1,2,3,4)
Output: 0

Element Sum: 1 + 2 + 3 + 4 = 10
Digit Sum: 1 + 2 + 3 + 4 = 10
Absolute Difference: | 10 - 10 | = 0
Example 4
Input: @ints = (236, 416, 336, 350)
Output: 1296
=end comment

=begin comment
Digit is used variously.  Constructs like "single digit number" suggest digit
is a symbol to construct numbers but not a number itself.
=end comment

my @Test =
    0,      0,       (1,2,3,4),
    0,      0,       (0,1,2,3,4),
    9,      9,       (1,12,3),
    36,     36,      (1,2,3,45),
    1296,   1296,    (236, 416, 336, 350),
    9,      9,       (1,2,3,15),
    -33,    -9,      (-1,-2,-3,-15),
    -21,    -9,      (1,2,3,-15),
    -21,    -9,      (0,1,2,3,-15),
    624,   648,    (236, 416, -336, 350),
;

plan @Test ÷ 3 × 2;

# alway consider "digits" to be positive
multi digit-sum( $a, Bool:D :$unsigned!  -->Int) {
    $a.sum - sum $a.map: { sum .abs.Str.comb».Int };
}
# consider "digits" to inherit the sign of the containing number
multi digit-sum( $a -->Int) {
    $a.sum
    - sum $a.map({
         if $_ > 0 {   sum .Str.comb».Int; }
         else      { - sum .abs.Str.comb».Int; }
     })
}

for @Test -> $pos, $signed, $in {
    #is digit-sum($in, :unsigned), $pos,    "$pos\t<- $in :unsigned digits";
        is digit-sum($in           ), $signed, "$signed\t<- $in";
}

done-testing;
my $ints = (1, 2, 3, -15);
say "\nInput: \$ints = $ints.raku()\nOutput: &digit-sum($ints, :unsigned)";
exit;

