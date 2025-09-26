#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;

=begin comment
Edited for space.

340-2: Ascending Numbers   Submitted by: Mohammad Sajid Anwar

You are given a string, $str, is a list of tokens separated by a single space. Every token is either a positive number consisting of digits 0-9 with no leading zeros, or a word consisting of lowercase English letters.

Write a script to check if all the numbers in the given string are strictly increasing from left to right.


=end comment

my @Test =
    "The cat has 3 kittens 7 toys 10 beds",         True,
    'Alice bought 5 apples 2 oranges 9 bananas',    False,
    'I ran 1 mile 2 days 3 weeks 4 months',         True,
    'Bob has 10 cars 10 bikes',                     False,
    'Zero is 0 one is 1 two is 2',                  True,
    'Zero is zero',                                 Bool,
    'Zero is 1',                                    Bool,
    '100000000',                                    Bool,
;
plan +@Test ÷ 2;

# Type object represents non-applicable.    # Blorst is all; all is blorst.
sub task( $a -->Bool) {
    return Bool if 1 ≥ +( my @int = $a.comb( / \d+ /)».Int);   # Ugly blorst!
    return [<] @int;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "The cat has 3 kittens 7 toys 10 beds";

say "\nInput: \$str = '$str'\nOutput: ", task $str;
