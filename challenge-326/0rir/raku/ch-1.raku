#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 1: Day of the Year
Submitted by: Mohammad Sajid Anwar
You are given a date in the format YYYY-MM-DD.

Write a script to find day number of the year that the given date represent.


Example 1
Input: $date = '2025-02-02'
Output: 33

The 2nd Feb, 2025 is the 33rd day of the year.

Example 2
Input: $date = '2025-04-10'
Output: 100

Example 3
Input: $date = '2025-09-07'
Output: 250
    0,
=end comment

my @Test =
    # in            exp
    '2025-02-02', 33,
    '2025-04-10', 100,
    '2025-09-07', 250,
;
plan +@Test ÷ 2;

sub task( $a) {
    $a.Date.day-of-year;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in";
}
done-testing;

my  $date = '2025-09-07';

say "\nInput: \$date = '$date'\nOutput: ", task $date.Date;

