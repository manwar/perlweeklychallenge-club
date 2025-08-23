#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
335-1: Common Characters    Submitted by: Mohammad Sajid Anwar
You are given an array of words.

Write a script to return all characters that is in every word in the given array including duplicates.

Example 1
Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")
…
Example 4
Input: @words = ("abc", "def", "ghi")
Output: ()
=end comment

my @Test =      # in                    #exp
    ("bella", "label", "roller"),   ("e", "l", "l"),
    ("cool", "lock", "cook"),       ("c", "o"),
    ("hello", "world", "pole"),     ("l", "o"),
    ("abc", "def", "ghi"),          (),
    ("aab", "aac", "aaa"),          ("a", "a"),
;
plan +@Test ÷ 2;

# Intersect of BagHashes is like Set ∩ but using the lesser quantity.
sub infix:<intersect>( BagHash $a, BagHash $b -->BagHash) {
    my BagHash $ret;
    my @key = ( $a.keys.Set ∩ $a.keys.Set).keys;
    for @key -> \k {
        $ret{k} = $a{k} min $b{k};
    }
   $ret
}

# Expand a BagHash to a List by adding each key by its value times;
multi expand( BagHash:U $a -->List ) { () }
multi expand( BagHash:D $a -->List) { $a.kxxv.sort.List }

sub task( @in -->List) { expand [intersect] (@in».comb)».BagHash; }

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my @word = "cool", "lock", "cook";

say "\nInput: @word = @word.raku()\nOutput: (\"",
        task( @word).sort.join('", "'), '")';
