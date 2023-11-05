#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
241-2: Prime Order              Submitted by: Mohammad S Anwar
Given an array of unique positive integers greater than 2, sort them in
ascending order of the count of their prime factors, tie-breaking by ascending
value.

Example 1
Input: @int = (11, 8, 27, 4)
Output: (11, 4, 8, 27))

Prime factors of 11 => 11
Prime factors of  4 => 2, 2
Prime factors of  8 => 2, 2, 2
Prime factors of 27 => 3, 3, 3
=end comment

my @Test =
    [11,8,27,4], [11,4,8,27],
    [8,27], [8,27],
    [27,8], [8,27],
;

plan @Test ÷ 2;

subset Positive of Int where * ≥ 1;

constant @prime = lazy 2,3, (* + 2 if *.is-prime) … ∞;

sub prime-factors( $n is copy -->Array) is export {
    my @ret;
    my $ix = 0;
    while $n > 1 {
        my $candi = @prime[$ix];
        $ix++;
        next unless ( $n %% $candi );
        $ix = 0;
        $n ÷= $candi;
        @ret.push: $candi;
    }
    return @ret;
}

sub sort-by-prime-factor-ct-then-val( @a) {
    @a.sort: { .&prime-factors.elems, $_  };
}

for @Test -> @in, @exp {
    is sort-by-prime-factor-ct-then-val(@in), @exp, "@in.raku() -> @exp.raku()";
}

done-testing;

my @a = 11, 2³, 3³, 2², 3, 97, 3²×11, 2²×5², 2³x3²×7×17×37, 2⁹;
say "Input: @int = @a.raku()\nOutput: &sort-by-prime-factor-ct-then-val( @a)";

exit;

