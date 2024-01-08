#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
249-2: DI String Match              Submitted by: Mohammad S Anwar
You are given a string s, consisting of only the characters "D" and "I".
Find a permutation of the integers [0 .. length(s)] such that for each character s[i] in the string:

s[i] == 'I' ⇒ perm[i] < perm[i + 1]
s[i] == 'D' ⇒ perm[i] > perm[i + 1]

Example 1
Input: $str = "IDID"
Output: (0, 4, 1, 3, 2)
Example 2
Input: $str = "III"
Output: (0, 1, 2, 3)
Example 3
Input: $str = "DDI"
Output: (3, 2, 0, 1)
=end comment

my @Test =
    "IDID", (0, 4, 1, 3, 2),
    "III",  (0, 1, 2, 3),
    "DDI",  (3, 2, 0, 1),
    "I",    (0,1),
    "D",    (1,0),
    "DDDDDDDIIIIIIIIII", (17,16,15,14,13,12,11,0,1,2,3,4,5,6,7,8,9,10,),
;
plan @Test ÷ 2;

sub i-did( Any:D(Str) $a where *.chars > 0, $low-char = 'I' --> List) {
    my @c = $a.comb;
    my ($i, $d) = 0, @c.elems;
    @c.=map( { $_ ~~ $low-char ?? $i++ !! $d-- } );
    @c.push:   $_ ~~ $low-char ?? $i   !! $d      ;
    @c.List;
}

for @Test -> $in, @exp {
    is i-did($in), @exp, "$in -> @exp.raku()";
}
done-testing;

my $str = "DDDDDDDIIIIIIIIII";
say "\nInput: \$str = $str\nOutput: &i-did( $str)";
exit;

