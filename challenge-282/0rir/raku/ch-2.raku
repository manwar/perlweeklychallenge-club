#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
282-2: Changing Keys        Submitted by: Mohammad Sajid Anwar

You are given an alphabetic string, $str, as typed by user.
Write a script to find the number of times user had to change the key to
type the given string. Changing key is defined as using a key different
from the last used key. The shift and caps lock keys won’t be counted.

Example 1
Input: $str = 'pPeERrLl'
Ouput: 3

p -> P : 0 key change
P -> e : 1 key change
e -> E : 0 key change
E -> R : 1 key change
R -> r : 0 key change
r -> L : 1 key change
L -> l : 0 key change

Example 2
Input: $str = 'rRr'
Ouput: 0
Example 3
Input: $str = 'GoO'
Ouput: 1
=end comment

my @Test =
    '',         0,
    'a',        0,
    'aA',       0,
    'pPeERrLl', 3,
    'rRr',      0,
    'GoO',      1,
;
plan @Test ÷ 2;

multi task( '' ) { 0 }
multi task( Str:D $a) {
    +$a.lc.comb.squish -1;
}

for @Test -> $in, $exp {
    is task($in), $exp, "$exp <- $in";
}
done-testing;

my $str = 'pPjtrliuhjtlijhaWRtaaeERrLl';
say "\nInput: \$str = '$str'\nOutput: { task $str }\n";

