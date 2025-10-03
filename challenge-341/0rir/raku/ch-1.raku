#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
Edited for space.
341-1: Broken Keyboard     Submitted by: Mohammad Sajid Anwar
You are given a string containing English letters only and also you are given broken keys.

Write a script to return the total words in the given sentence can be typed completely.

Example 1
Input: $str = 'Hello World' @keys = ('d')
Output: 1

=end comment

my @Test =
    #   str                     keys            exp
    'Hello World',              ('d',),          1,
    'apple banana cherry',      ('a','e',),      0,
    'Coding is fun',            (),              3,
    'The Weekly Challenge',     ('a','b'),       2,
    'Perl and Python',          ('p',),          1,
;
plan +@Test ÷ 3;

multi task( Str:D $str, List $keys where * ~~ Empty -->Int) { + $str.words }
multi task( Str:D $str, List $keys                  -->Int) {
    my $ret = 0;
    my $kset = Set.new: $keys».lc;
    for $str.lc.words {
        my $ws = .comb.Set;
        ++ $ret unless  $kset ∩ .comb.Set;
     }
    $ret;
}

for @Test -> $in, @ks, $exp {
    is task( $in, @ks), $exp, "{$exp // $exp.^name()} <- $in ∘∘ @ks.raku()";
}
done-testing;

my $str  = 'Perl and Python';
my @keys = 'p', 'z', 'y';

say "\nInput: \$str = '$str', @keys = @keys.raku()",
    "\nOutput: ", task($str, @keys);
