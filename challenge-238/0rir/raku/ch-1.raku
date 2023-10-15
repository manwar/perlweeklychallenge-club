#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ »
use v6.d;
use Test;

=begin comment
238-1: Running Sum         Submitted by: Mohammad S Anwar
Given an array of integers, return the running sum of the given array.
The running sum can be calculated as sum[i] = num[0] + num[1] + …. + num[i].

Example 1
Input: @int = (1, 2, 3, 4, 50
Output: (1, 3, 6, 10, 15)
Example 2
Input: @int = (1, 1, 1, 1, 1)
Output: (1, 2, 3, 4, 5)
Example 3
Input: @int = (0, -1, 1, 2)
Output: (0, -1, 0, 2)

=end comment

my @Test =
        #in                ex;
    (1, 2, 3, 4, 5),    (1, 3, 6, 10, 15),
    (1, 1, 1, 1, 1),    (1, 2, 3, 4, 5),
    (0, -1, 1, 2),      (0, -1, 0, 2),
;

plan @Test ÷ 2;

sub func( List $in ) {
    $in.map(
        { state $r += $_; $r<>; }
    ).List;
}

for @Test -> $in, @exp {
    is func($in), @exp, "@exp.raku() <- $in";
}

done-testing;

my $int = @Test[0];
say "\nInput: @int = $int\nOutput: ", func( $int);

exit;

