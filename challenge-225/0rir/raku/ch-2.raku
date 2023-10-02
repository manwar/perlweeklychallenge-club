#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
225-2: Left Right Sum Diff              Submitted by: Mohammad S Anwar
You are given an array of integers, @ints, return the left right sum diff array as shown below:

@ints = (a, b, c, d, e)

@left  = (0, a, (a+b), (a+b+c))
@right = ((c+d+e), (d+e), e, 0)
@left_right_sum_diff = ( | 0 - (c+d+e) |,
                         | a - (d+e)   |,
                         | (a+b) - e   |,
                         | (a+b+c) - 0 | )

Example 1:
Input: @ints = (10, 4, 8, 3)
Output: (15, 1, 11, 22)

@left  = (0, 10, 14, 22)
@right = (15, 11, 3, 0)

@left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)
                     = (15, 1, 11, 22)
=end comment

my @int = 10, 4, 8, 3;

sub l-r-sum-diff( @a = [10, 4, 8, 3] -->Array) {
    my @l = 0, | do for 0..2        { [+] @a[0..$_]       }
    my @r =    | do for @a-3...@a-1 { [+] @a[@a.end...$_] }, 0;
    @     =    do for ^@l -> $i { abs( @l[$i] - @r[$i] ) }
}

say "Input: @int = @int.raku()\nOutput: " ~ l-r-sum-diff().raku;

