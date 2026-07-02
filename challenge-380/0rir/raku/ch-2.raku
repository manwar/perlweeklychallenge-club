#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
380-2: Armstrong Number     Submitted by: Mohammad Sajid Anwar

You are given two integers, $base and $limit.
Write a script to find all Armstrong numbers in base $base that are less than $limit.
    If raising each of the digits of a nonnegative integer to the power of the total number of digits, then taking the sum, equals the original number, it is an Armstrong number.
=end comment

my @Test =
    # base      limit   exp
    10,  1000, (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407),
    7,   1000, (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250),
    16,  1000, (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
                    342, 371, 520, 584, 645),
;
plan +@Test ÷ 3;

sub task( Int $base where * ~~ 2..32, Int $limit where -1 < * -->Array) {
    my @ret;
    for 0 … $limit -> $n {
        my Str $base-num = $n.base($base);
        my $power        = $base-num.chars;
        if $n == sum $base-num.comb».parse-base($base)».&( * ** $power) {
            @ret.push( $n);
        }
    }
    @ret;
}

for @Test -> $base, $limit, @exp {
    is task( $base, $limit), @exp, "@exp[] <- $base ∘∘ $limit";
}
done-testing;

my $base = 7;
my $limit = 100000;

say qq{\nInput: \$base = $base, \$limit = $limit\nOutput: (},
    task($base, $limit).join(', ') ~ ')'; 
