#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
305-1: Binary Prefix        Submitted by: Mohammad Sajid Anwar
You are given a binary array.

Write a script to return an array of booleans where the partial binary number up to that point is prime.

Example 1
Input: @binary = (1, 0, 1)
Output: (false, true, true)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 0): 2 - prime
(1, 0, 1): 5 - prime
Example 2
Input: @binary = (1, 1, 0)
Output: (false, true, false)

Sub-arrays (base-10):
(1): 1 - not prime
(1, 1): 3 - prime
(1, 1, 0): 6 - not prime
Example 3
Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
Output: (false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true)

=end comment

constant \f = False;
constant \t = True;

my @Test =
    # in         out
    (1, 0, 1), (f, t, t),
    (1, 1, 0), (f, t, f),
    (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1),
               (f, t, t, f, f, t, f, f, f, f, f, f, f, f, f, f, f, f, f, t),
;
plan 2 × @Test ÷ 2;

sub task1( @a) {
    do for ^@a {
        @a[0..$_].join.parse-base(2).is-prime;
    }
}
sub task2( @a) {
    my $str = @a.join;
    return do for 1..$str.chars {
        $str.substr(0, $_).parse-base(2).is-prime;
    }
}

for @Test -> @in, @out {
    is task1( @in), @out, (@out».Str).join(' ').raku() ~ " <- @in.raku()";
    is task2( @in), @out, (@out».Str).join(' ').raku() ~ " <- @in.raku()";
}


done-testing;

use Bench;
my $b = Bench.new;

$b.cmpthese(10_000, {
    Ary-y  => sub { for @Test -> @in, @junk { task1( @in) } },
    Str-y  => sub { for @Test -> @in, @junk { task2( @in) } },
});


my @binary = 1, 0, 1, 1, 0, 1, 1, 1;
say "\nInput: @binary = @binary[]\nOutput: { task2 @binary }";

