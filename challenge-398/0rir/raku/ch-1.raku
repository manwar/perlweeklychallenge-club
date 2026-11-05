#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited for no good reason:
398-Task 1: Divisible Average   Submitted by: Mohammad Sajid Anwar
You are given an array of positive integers.
Write a script to return the closest integer to the mean value of all even integers that are divisible by 3. If none is divisible, return 0.
=end comment

my @Test =
    # in                            exp
    (18, 5, 7, 11),                 18,
    (6, 12, 18, 24, 30, 40),        18,
    (3, 9, 15, 21, 27),              0,
    (6, 12, 14, 20),                 9,
    (6, 6, 6, 12, 12),               8,
;
plan @Test ÷ 2;

sub task( List $a where *.are( Int) -->Int) {
    my @sixer =  $a.grep: * %% 6;
    return 0 if @sixer == 0;
    ( @sixer.sum ÷ @sixer).round(1);
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp <- @in.raku[]"
}
done-testing;

my @arr = 6, 6, 6, 12, 12;
say qq{\nInput: @arr = ({@arr.join(', ')})\nOutput: }, task @arr;
