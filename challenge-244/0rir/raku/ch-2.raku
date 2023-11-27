#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;


=begin comment
244 2: Group Hero            Submitted by: Mohammad S Anwar
You are given an array of integers representing the strength.
Write a script to return the sum of the powers of all possible combinations; power is defined as the square of the largest number in a sequence, multiplied by the smallest.


Example 1
Input: @nums = (2, 1, 4)
Output: 141

Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141

=end comment

my @Test =
    # in                    exp
    (0,),                   0,
    (1,),                   1,
    (1,0),                  1,
    (-10, -1, 5),       -1411,
    (2, 0, 1, -10),     -1167,
    (2, 1, 4),            141,
    (2,2,2,2),            120,
;

plan @Test ÷ 2;

sub func( @a where *.end > -1) {
   [+] @a.combinations( 1..@a).map: { .min × .max² } ; # do-able w/ Whatever?
}

for @Test -> @in, $exp {
    is func(@in), $exp, "$exp <= @in[]";
}

done-testing;

my @num = 2, 0, 1, -10;
say "\nInput: @num = @num[]\nOutput: ", func( @num).raku;
exit;

