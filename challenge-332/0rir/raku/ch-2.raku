#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
332-Task 2: Odd Letters     Submitted by: Mohammad Sajid Anwar
You are given a string.

Write a script to find out if each letter in the given string appeared odd number of times.


Example 1
Input: $str = "weekly"
Output: false

w: 1 time
e: 2 times
k: 1 time
l: 1 time
y: 1 time

The letter 'e' appeared 2 times i.e. even.

Example 2
Input: $str = "perl"
Output: true

Example 3
Input: $source = "challenge"
Output: false
=end comment

my @Test =
    "weekly",       False,
    "perl",         True,
    "challenge",    False,
    "abcdefghijk",  True,
    'a-b_c+d×e%f&123()gh=ijk',  True,
    'a-a_c+d×e%f&123()gh=ijk',  False,
;
plan +@Test ÷ 2;

sub task( Str $a -->Bool) {
    !defined
        $a.comb.grep( /<:L>/ )
            .Bag.first( :k, *.value %% 2[0])
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $source = "mn * o - p + qr - s^^3 ~ aaa	# wxyz";
say qq{\nInput: \$source = "$source"\n}
  ~ qq{Output: &task($source)};
