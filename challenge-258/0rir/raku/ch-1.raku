#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
258-1: Count Even Digits Number         Submitted by: Mohammad Sajid Anwar
You are given a array of positive integers, @ints.

Write a script to find out how many integers have even number of digits.

Example 1
Input: @ints = (10, 1, 111, 24, 1000)
Output: 3

There are 3 integers having even digits i.e. 10, 24 and 1000.
Example 2
Input: @ints = (111, 1, 11111)
Output: 0
Example 3
Input: @ints = (2, 8, 1024, 256)
Output: 1
=end comment

my @Test =
    # @int                      $exp
    (),                         0,      # c/b Int
    (1),                        0,
    (22),                       1,
    (10, 1, 111, 24, 1000),     3,
    (111, 1, 11111),            0,
    (2, 8, 1024, 256),          1,
;
plan @Test ÷ 2;

sub func( $a) {
    +@$a.grep( *.Str.chars %% 2 )
}

for @Test -> $in, $exp {
    is func(@$in), $exp, "$exp <- $in";
}

done-testing;
my $X = (2, 8, 1024, 256);

say "\nInput: @int = @$X.raku()\nOutput: &func($X)";

exit;

