#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
Edited for space.
342-2: Max Score        Submitted by: Mohammad Sajid Anwar
You are given a string, $str, containing 0 and 1 only.

Write a script to return the max score after splitting the string into two non-empty substrings. The score after splitting a string is the number of zeros in the left substring plus the number of ones in the right substring.



=end comment

my @Test =
    # in            exp
    "0011",         4,
    "0000",         3,
    "1111",         3,
    "0101",         3,
    "011101",       5,
;
plan +@Test ÷ 2;

sub task( Str:D $a where *.chars > 1 --> Int) {

            # make Int arrays for ones and noughts
    my @l = $a.comb».Int».not».Int;
    my @r = $a.comb.reverse».Int;
            # set the sum for the head and tail of each slice pair of $a.comb
    for @l, @r -> @c {
        my $sum = 0;
        for ^@l -> \i {
            @c[i] = @c[i] ?? ++$sum !! $sum;
        }
    }
    @r = @r.reverse.Array;

    my $max = 0;
    for 1..^@l -> \i {
        $max max= @l[i-1] + @r[i]
    }
    return $max;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = (  do for ^((^10).pick+15) { (^2).pick }  ).join;
say qq|\nInput: \$str = "$str"\nOutput: &task($str)|;

