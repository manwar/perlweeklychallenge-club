#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
252-2: Unique Sum Zero          Submitted by: Mohammad S Anwar

You are given an integer, $n.  Write a script to find an array containing
$n unique integers such that they add up to zero.

Example 1
Input: $n = 5
Output: (-7, -1, 1, 3, 4)

Two other possible solutions could be as below:
(-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).
Example 2
Input: $n = 3
Output: (-1, 0, 1)
Example 3
Input: $n = 1
Output: (0)

=end comment

my @Test =   5, [-2..2],
            11, [-5..5],
            21, [-10..10],
;
my @Die = 500, -6,  0;

plan +@Test + @Die;

my $range = 100_000;

sub func( $n, Int $abs-range = $range) {
    die "Domain error" if $abs-range × 2 + 1 < $n;
    die "Invalid index" if $n < 1;
    my @a = ( -$abs-range..$abs-range).pick( $n-1).Array; ;
    @a.push: 0 - @a.sum;
    @a
}

for @Test -> $n, @exp {
    my @return = func( $n, ($n div 2));
    is +@return, $n, "Array size";
    is @return.sort.Array, @exp, "Array values";
}
for @Die -> $n {
    my $range = 10;
    dies-ok { func $n, $range }, 
        "$n is invalid (\$range is -$range..$range)";
}
done-testing;

my $n = 99;
say "\nInput: \$n = $n\nOutput: ", func( $n );

