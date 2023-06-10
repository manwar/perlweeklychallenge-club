#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
220-1: Common Characters        Submitted by: Mohammad S Anwar
Given a list of words, return the list of characters (sorted alphabeticall) found in every word of the given list.

Example 1
Input: @words = ("Perl", "Rust", "Raku")
Output: ("r")
Example 2
Input: @words = ("love", "live", "leave")
Output: ("e", "l", "v")
=end comment

my @Test =
    < r >,          ("Perl", "Rust", "Raku"),
    < e l v >,      ("love", "live", "leave"),
    < e l v >,      ("loove", "live", "leave"),
    (),             ("happiness", "rich", "common"),
    < e s >,        ("happiness", "riches", "commonness"),
    < g o >,        <god dog dogooder dogged gold goose gooseneck
                        gosling goes vetoing gasoline gooey plodding
                        goon gong Gideon gobsmacking forgotten foundling
                        dingdong dotting encompassing openning begoggled
                        monogamy 
                    >,
    < g o >,       ( <god dog dogooder dogged gold goose gooseneck
                        gosling goes vetoing gasoline gooey plodding
                        goon gong Gideon gobsmacking forgotten foundling
                        dingdong dotting encompassing openning begoggled
                        monogamy 
                    > xx 1000).flat,
;
plan @Test ÷ 2;

sub universal-letters( @a) {
    my @w = @a».lc;
    my @ret = @w.pop.comb;
    for @w -> $word {
        @ret = $word.comb.unique.grep( * ~~ @ret.any);
        return [] if @ret ~~ Empty;
    }
    @ret.sort.Array;
}

for @Test -> $exp, $in {
    is universal-letters(@$in), @$exp, "@$exp.raku()\t<-- @$in[]";
}
done-testing;

my @word = ("happiness", "riches", "commonness");
say "\nInput: @words = @word.raku()\nOutput: ", universal-letters(@word).raku;
