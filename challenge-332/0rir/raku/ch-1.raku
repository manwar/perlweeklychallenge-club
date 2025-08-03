#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
332-Task 1: Binary Date     Submitted by: Mohammad Sajid Anwar
You are given a date in the format YYYY-MM-DD.

Write a script to convert it into binary date.


Example 1
Input: $date = "2025-07-26"
Output: "11111101001-111-11010"

Example 2
Input: $date = "2000-02-02"
Output: "11111010000-10-10"

Example 3
Input: $date = "2024-12-31"
Output: "11111101000-1100-11111"
=end comment

my @Test =
    "2025-07-26", "11111101001-111-11010",
    "2000-02-02", "11111010000-10-10",
    "2024-12-31", "11111101000-1100-11111",
;
plan +@Test ÷ 2;

sub task( $a) {
    join '-', $a.split( '-').map: *.Int.base(2);
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $date = "2525-01-01";
say "
Input: \$date = \"$date\"
Output: \"", &task( $date), '"';

