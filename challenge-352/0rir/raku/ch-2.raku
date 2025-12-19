#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
May be edited for space.
352-2: Binary Prefix        Submitted by: Mohammad Sajid Anwar
You are given an array, @nums, where each element is either 0 or 1.

Define xi as the number formed by taking the first i+1 bits of @nums (from $nums[0] to $nums[i]) and interpreting them as a binary number, with $nums[0] being the most significant bit.

For example:

If @nums = (1, 0, 1), then:

x0 = 1 (binary 1)
x1 = 2 (binary 10)
x2 = 5 (binary 101)

For each i, check whether xi is divisible by 5.
Write a script to return an array @answer where $answer[i] is true if x<sub>i</sub> is divisible by 5, otherwise false.

=end comment

my (\F, \T) = False, True;

my @Test =
    # input           expect
    (0,1,1,0,0,1,0,1,1,1),          (T, F, F, F, F, T, T, F, F, F),
    (1,0,1,0,1,0),                  (F, F, T, T, F, F),
    (0,0,1,0,1),                    (T, T, F, F, T),
    (1,1,1,1,1),                    (F, F, F, T, F),
    (1,0,1,1,0,1,0,0,1,1),          (F, F, T, F, F, T, T, T, F, F),
    (0,1,0,1,0,0,0,0,0,0,0,0,0,0,0),(T,F,F,T,T,T,T,T,T,T,T,T,T,T,T),
;
plan +@Test ÷ 2;

sub task( @a is copy, $divr = 5  -->Array) {
    my $in = @a.join;
    my @ret;
    for 1..$in.chars -> $tail {
       @ret.push( $in.substr(0,$tail).parse-base(2) %% $divr );
    }
    @ret
}

for @Test -> $in, $exp {
    is task( $in), $exp, " $in.join()";
}
done-testing;

my  @num = (0,1,1,0,0,1,0,1,1,1);

say qq{\nInput: @num = (@num.join(','))}
~ qq{\nOutput: (}, (task( @num)».lc).join( ', '), ')';
