#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
316-1 Circular      Submitted by: Mohammad Sajid Anwar
You are given a list of words.
Write a script to find out whether the last character of each word is the first character of the following word.

Example 1
Input: @list = ("perl", "loves", "scala")
Output: true

Example 2
Input: @list = ("love", "the", "programming")
Output: false

Example 3
Input: @list = ("java", "awk", "kotlin", "node.js")
Output: true

=end comment

my @Test =
    ("java", "awk", "kotlin", "node.js"),   True,
    ("love", "the", "programming"),         False,
    ("perl", "loves", "scala"),             True,
    ('a',),                                 Bool,
    (),                                     Bool,
;
plan @Test ÷ 2;

multi task( @a where *.elems < 2 -->Bool ) { Bool }
multi task( @a                   -->Bool ) {
    for @a.rotor( 2 => -1) ->@d {
        return False if @d[0].substr( *-1,1) ne @d[1].substr( 0,1);
    }
    True;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my @list = ("java", "awk", "kotlin", "node.js");
say qq{\nInput: @list = ("@list.join( '", "')")}
    ~ "\nOutput: &task( @list)";

