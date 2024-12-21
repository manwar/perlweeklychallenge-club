#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
300-1: Beautiful Arrangement        Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.
Write a script to return the number of beautiful arrangements that you can construct.
A permutation of n integers, 1-indexed, is considered a beautiful arrangement
if for every i (1 <= i <= n) either of the following is true:

1) perm[i] is divisible by i
2) i is divisible by perm[i]
Example 1
Input: $n = 2
Output: 2

1st arrangement: [1, 2]
    perm[1] is divisible by i = 1
    perm[2] is divisible by i = 2
2nd arrangement: [2, 1]
    perm[1] is divisible by i = 1
    i=2 is divisible by perm[2] = 1
Example 2
Input: $n = 1
Output: 1
Example 3
Input: $n = 10
Output: 700

=end comment

my @Test =
    # in    exp
    0,      Int,
    1,      1,
    2,      2,
    3,      3,
    4,      8,
    5,      10,
    6,      36,
    7,      41,
    8,      132,
#   9,      240,
#   10,     700,
;
plan @Test ÷ 2;

my @beaut = 0,1,2,3,8,10,36,41,132,250,700;

sub task( $n --> Int) {
    return Int if $n == 0;
    my $ct  = 0;
    my @a = 1..$n;
    for @a.permutations -> @p  {
        my @t = @p Z=> [1..$n];
        ++$ct if @t.all.&pretty-pair();
    }
    $ct;
}
sub pretty-pair( Pair $p -->Bool) {
    return True if $p.value %% $p.key or $p.key %% $p.value ;
    False;
}

for @Test -> $in, $exp {
    is task($in), $exp, ($exp // "Int") ~ " <- $in";
}

done-testing;

my $n = 8;
say "\nInput: \$n = $n\nOutput: {task $n}";

