#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited for no good reason:
3971: Absent Smallest Positive       Submitted by: Mohammad Sajid Anwar
Given an array of integers, write a script to return the smallest absent
positive integer such that it is strictly greater than the average of all
 elements in the given array.
=end comment

my @Test =
    # in                exp
    (1, 2, 4, 5, 6),     7,
    (-5, -2, -1, 3),     1,
    (1, 2, 3),           4,
    (2, 3, 7, 8),        6,
    (1, 1, 1, 10),       4,
;
plan @Test ÷ 2;

sub task( List $a -->Int:D) {   
    my $bad = $a.Set;
    my $candi = (sum(@$a) ÷ @$a).floor + 1;
    $candi = $candi ≤ 0 ?? 1 !! $candi;
    ++$candi while $bad ∋ $candi;
    $candi;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp $in.raku()"
}
done-testing;

my @arr = (-30 .. 30).pick(  (4..8).pick);

say qq{\nInput: @arr = ( @arr.join(', '))\nOutput: }, task @arr;
